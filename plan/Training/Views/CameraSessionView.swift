//
//  CameraSessionView.swift
//  PoonaApp
//

import SwiftUI
import AVFoundation

struct CameraSessionView: View {
    @Bindable var viewModel: TrainingSessionViewModel
    let trainingType: TrainingModule.TrainingType
    @Environment(\.dismiss) private var dismiss

    private let cameraState = CameraState()
    private let cameraManager: CameraSessionManager
    private let poseState = PoseDetectionState()
    private let poseService: PoseDetectionService
    private let strokeAnalysisState = StrokeAnalysisState()
    private let strokeAnalysisService: StrokeAnalysisService
    private let previewSizeBox = PreviewSizeBox()
    @State private var previewSize: CGSize = .zero
    @State private var videoDelegate: CameraSessionViewDelegate?
    private let videoQueue = DispatchQueue(label: "com.poonaapp.video")

    init(viewModel: TrainingSessionViewModel, trainingType: TrainingModule.TrainingType) {
        self.viewModel = viewModel
        self.trainingType = trainingType
        self.cameraManager = CameraSessionManager(state: cameraState)
        self.poseService = PoseDetectionService(state: poseState)
        self.strokeAnalysisService = StrokeAnalysisService(
            config: trainingType == .forehand ? .forehand : .backhand
        )
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                CameraPreviewView(session: cameraManager.captureSession)
                    .ignoresSafeArea()
                    .onAppear {
                        previewSize = geometry.size
                        previewSizeBox.size = geometry.size
                    }
                    .onChange(of: geometry.size) { _, newSize in
                        previewSize = newSize
                        previewSizeBox.size = newSize
                    }

                JointsOverlayView(detectedBody: poseState.detectedBody, jointAngles: viewModel.jointAngles)
                    .ignoresSafeArea()

                if shouldShowGuide {
                    BodyPositionGuideView()
                        .transition(.opacity)
                }

                if case .failed(let error) = cameraState.state {
                    CameraErrorView(error: error)
                        .transition(.opacity)
                }

                if case .countdown(let value) = viewModel.sessionState {
                    CountdownOverlayView(value: value)
                        .transition(.opacity)
                }

                if let summary = strokeAnalysisState.sessionSummary {
                    SessionSummaryOverlay(
                        summary: summary,
                        feedback: strokeAnalysisState.sessionFeedback,
                        onDismiss: { dismiss() }
                    )
                    .transition(.opacity)
                }

                VStack {
                    HStack {
                        if case .sessionActive = viewModel.sessionState {
                            Text(viewModel.formattedRemainingTime)
                                .font(.system(size: 18, weight: .semibold, design: .monospaced))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(.black.opacity(0.6))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    Spacer()

                    if case .sessionActive = viewModel.sessionState {
                        Text("Strokes: \(strokeAnalysisState.strokeCount)")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.black.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.bottom, 16)
                    }

                    HStack {
                        Button(action: {}) {
                            Image(systemName: "camera.trianglebadge.exclamationmark")
                                .font(.system(size: 24))
                                .frame(width: 72, height: 72)
                        }
                        .disabled(true)
                        .opacity(0.6)

                        Spacer()

                        Button(action: {
                            endSession()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 72, height: 72)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.white)
                                    .frame(width: 24, height: 24)
                            }
                        }

                        Spacer()

                        Circle()
                            .fill(Color.clear)
                            .frame(width: 72, height: 72)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            videoDelegate = CameraSessionViewDelegate(
                poseService: poseService,
                previewSizeBox: previewSizeBox
            )
            
            strokeAnalysisService.onStrokeDetected = { result in
                Task { @MainActor in
                    strokeAnalysisState.appendStroke(result)
                }
            }
            
            Task {
                await cameraManager.checkAuthorization()
                await cameraManager.setupSession()
                cameraManager.configureVideoOutput(delegate: videoDelegate!, queue: videoQueue)
                await cameraManager.startSession()
                viewModel.startSession()
            }
        }
        .onDisappear {
            endSession()
            cameraManager.stopSession()
            cameraManager.teardown()
            viewModel.reset()
        }
        .onChange(of: poseState.detectedBody) { _, newBody in
            viewModel.updateDetectedBody(newBody)
            
            if case .sessionActive = viewModel.sessionState,
               let body = newBody,
               !viewModel.jointAngles.isEmpty {
                let elapsed = viewModel.selectedConfig.duration - viewModel.remainingTime
                strokeAnalysisService.process(
                    body: body,
                    angles: viewModel.jointAngles,
                    timestamp: elapsed
                )
            }
        }
        .onChange(of: viewModel.sessionState) { _, newState in
            if newState == .sessionEnded {
                endSession()
            }
        }
    }

    private var shouldShowGuide: Bool {
        viewModel.sessionState == .idle
    }

    private func endSession() {
        viewModel.stopSession()
        strokeAnalysisState.finalizeSession(trainingType: trainingType.rawValue)
    }
}

private final class PreviewSizeBox {
    var size: CGSize = .zero
}

private final class CameraSessionViewDelegate: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    let poseService: PoseDetectionService
    let previewSizeBox: PreviewSizeBox

    init(poseService: PoseDetectionService, previewSizeBox: PreviewSizeBox) {
        self.poseService = poseService
        self.previewSizeBox = previewSizeBox
        super.init()
    }

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        let size = previewSizeBox.size
        guard size != .zero else { return }
        poseService.processFrame(sampleBuffer, previewSize: size)
    }
}

private struct CameraErrorView: View {
    let error: Error

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: Spacing.lg) {
                Image(systemName: "video.slash")
                    .font(.system(size: 64))
                    .foregroundStyle(.red)

                Text("Camera Unavailable")
                    .font(.poonaTitle)
                    .foregroundStyle(.white)

                Text(error.localizedDescription)
                    .font(.poonaBodySecondary)
                    .foregroundStyle(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, Spacing.xl)
            }
        }
    }
}

private struct SessionSummaryOverlay: View {
    let summary: SessionAnalysisSummary
    let feedback: [String]
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.85).ignoresSafeArea()

            ScrollView {
                VStack(spacing: Spacing.lg) {
                    Text("Session Complete")
                        .font(.poonaLargeTitle)
                        .foregroundStyle(.white)

                    VStack(alignment: .leading, spacing: Spacing.md) {
                        SummaryRow(label: "Total Strokes", value: "\(summary.totalStrokes)")
                        SummaryRow(label: "Average Score", value: String(format: "%.1f", summary.averageScore))
                        SummaryRow(label: "Best Score", value: String(format: "%.1f", summary.bestScore))
                        
                        Divider().background(.white.opacity(0.3))
                        
                        Text("Quality Breakdown")
                            .font(.poonaCTALabel)
                            .foregroundStyle(.white)
                        
                        HStack(spacing: Spacing.lg) {
                            QualityBadge(label: "Perfect", count: summary.qualityDistribution.perfect, color: .green)
                            QualityBadge(label: "Good", count: summary.qualityDistribution.good, color: .yellow)
                            QualityBadge(label: "Miss", count: summary.qualityDistribution.miss, color: .red)
                        }
                    }
                    .padding(Spacing.lg)
                    .background(.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: Radius.lg))

                    VStack(alignment: .leading, spacing: Spacing.md) {
                        Text("Feedback")
                            .font(.poonaCTALabel)
                            .foregroundStyle(.white)
                        
                        ForEach(feedback, id: \.self) { item in
                            Text("\u{2022} \(item)")
                                .font(.poonaBody)
                                .foregroundStyle(.white.opacity(0.9))
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(Spacing.lg)
                    .background(.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: Radius.lg))

                    Button(action: onDismiss) {
                        Text("Done")
                            .font(.poonaCTALabel)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, Spacing.md)
                            .background(Color.poonaAccent)
                            .clipShape(RoundedRectangle(cornerRadius: Radius.full))
                    }
                }
                .padding(.horizontal, Spacing.lg)
                .padding(.vertical, Spacing.xl)
            }
        }
    }
}

private struct SummaryRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.poonaBody)
                .foregroundStyle(.white.opacity(0.7))
            Spacer()
            Text(value)
                .font(.poonaBody.bold())
                .foregroundStyle(.white)
        }
    }
}

private struct QualityBadge: View {
    let label: String
    let count: Int
    let color: Color

    var body: some View {
        VStack(spacing: Spacing.xs) {
            Text("\(count)")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(color)
            Text(label)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CameraSessionView(viewModel: TrainingSessionViewModel(), trainingType: .forehand)
}
