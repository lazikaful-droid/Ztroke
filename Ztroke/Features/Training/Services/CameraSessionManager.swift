import AVFoundation
import Observation

@MainActor
@Observable
final class CameraState {
    enum SessionState {
        case idle
        case running
        case failed(Error)
    }

    var state: SessionState = .idle
    var isAuthorized: Bool = false
}

final class CameraSessionManager: @unchecked Sendable {
    private let state: CameraState
    private var session: AVCaptureSession
    private let sessionQueue = DispatchQueue(label: "com.ztroke.camera.session")
    private var videoOutput: AVCaptureVideoDataOutput?

    init(state: CameraState) {
        self.state = state
        self.session = AVCaptureSession()
    }

    private func createNewSession() {
        session = AVCaptureSession()
    }

    func checkAuthorization() async {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            await MainActor.run { state.isAuthorized = true }
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            await MainActor.run { state.isAuthorized = granted }
        case .denied, .restricted:
            await MainActor.run { state.isAuthorized = false }
        @unknown default:
            await MainActor.run { state.isAuthorized = false }
        }
    }

    func setupSession() async {
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            sessionQueue.async { [weak self] in
                guard let self else {
                    continuation.resume()
                    return
                }

                self.createNewSession()

                session.beginConfiguration()
                session.sessionPreset = .hd1920x1080

                guard let camera = AVCaptureDevice.default(
                    .builtInWideAngleCamera,
                    for: .video,
                    position: .front
                ) else {
                    Task { @MainActor in
                        self.state.state = .failed(CameraError.cameraUnavailable)
                    }
                    continuation.resume()
                    return
                }

                do {
                    let input = try AVCaptureDeviceInput(device: camera)
                    guard session.canAddInput(input) else {
                        Task { @MainActor in
                            self.state.state = .failed(CameraError.cannotAddInput)
                        }
                        continuation.resume()
                        return
                    }
                    session.addInput(input)

                    let videoOutput = AVCaptureVideoDataOutput()
                    videoOutput.videoSettings = [
                        kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
                    ]

                    guard session.canAddOutput(videoOutput) else {
                        Task { @MainActor in
                            self.state.state = .failed(CameraError.cannotAddOutput)
                        }
                        continuation.resume()
                        return
                    }
                    session.addOutput(videoOutput)
                    self.videoOutput = videoOutput

                    session.commitConfiguration()

                    Task { @MainActor in
                        self.state.state = .idle
                    }
                    continuation.resume()
                } catch {
                    Task { @MainActor in
                        self.state.state = .failed(error)
                    }
                    continuation.resume()
                }
            }
        }
    }

    func startSession() async {
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            sessionQueue.async { [weak self] in
                guard let self else {
                    continuation.resume()
                    return
                }
                guard !session.isRunning else {
                    continuation.resume()
                    return
                }
                session.startRunning()
                Task { @MainActor in
                    self.state.state = .running
                }
                continuation.resume()
            }
        }
    }

    func stopSession() {
        sessionQueue.async { [weak self] in
            guard let self, session.isRunning else { return }
            session.stopRunning()
            Task { @MainActor in
                self.state.state = .idle
            }
        }
    }

    func teardown() {
        sessionQueue.async { [weak self] in
            guard let self else { return }
            self.videoOutput?.setSampleBufferDelegate(nil, queue: nil)
            self.session.beginConfiguration()
            self.session.inputs.forEach { self.session.removeInput($0) }
            self.session.outputs.forEach { self.session.removeOutput($0) }
            self.session.commitConfiguration()
            self.videoOutput = nil
        }
    }

    func configureVideoOutput(delegate: AVCaptureVideoDataOutputSampleBufferDelegate, queue: DispatchQueue) {
        videoOutput?.setSampleBufferDelegate(delegate, queue: queue)
    }

    var captureSession: AVCaptureSession {
        session
    }
}

enum CameraError: LocalizedError {
    case cameraUnavailable
    case cannotAddInput
    case cannotAddOutput

    var errorDescription: String? {
        switch self {
        case .cameraUnavailable: return "Camera is not available"
        case .cannotAddInput: return "Cannot add camera input to session"
        case .cannotAddOutput: return "Cannot add video output to session"
        }
    }
}
