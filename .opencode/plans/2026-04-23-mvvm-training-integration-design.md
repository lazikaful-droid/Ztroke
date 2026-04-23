# MVVM Refactor + Training Feature Integration

## Overview

Refactor Ztroke codebase to proper MVVM architecture and integrate camera-based training features from the plan folder. This replaces the empty Practice flow with real pose detection, stroke analysis, and session feedback.

## Approach

Full integration + MVVM refactor in a single pass. Decompose the monolithic `AppViewModel` into feature-specific ViewModels, create design tokens, and adapt all plan folder files to Ztroke naming conventions.

## Project Structure

```
Ztroke/
├── App/
│   ├── ZtrokeApp.swift
│   └── AppCoordinator.swift
├── Core/
│   ├── DesignTokens/
│   │   ├── Spacing.swift
│   │   ├── Radius.swift
│   │   └── Font+Ztroke.swift
│   └── Extensions/
│       └── DataModel.swift
├── Features/
│   ├── Home/
│   │   ├── ViewModels/
│   │   │   └── HomeViewModel.swift
│   │   └── Views/
│   │       ├── MainScreen.swift
│   │       └── CameraSetUpScreen.swift
│   ├── Training/
│   │   ├── Models/
│   │   │   ├── DetectedBody.swift
│   │   │   ├── JointAngle.swift
│   │   │   ├── PoseData.swift
│   │   │   ├── SessionConfig.swift
│   │   │   ├── SessionState.swift
│   │   │   ├── StrokeAnalysisConfig.swift
│   │   │   ├── StrokeAnalysisResult.swift
│   │   │   ├── SessionAnalysisSummary.swift
│   │   │   └── TrainingModule.swift
│   │   ├── Services/
│   │   │   ├── CameraSessionManager.swift
│   │   │   ├── PoseDetectionService.swift
│   │   │   ├── JointAngleCalculator.swift
│   │   │   ├── StrokeAnalysisService.swift
│   │   │   └── FeedbackEngine.swift
│   │   ├── ViewModels/
│   │   │   ├── TrainingSessionViewModel.swift
│   │   │   └── StrokeAnalysisState.swift
│   │   └── Views/
│   │       ├── CameraPreviewView.swift
│   │       ├── CameraSessionView.swift
│   │       ├── TrainingSetupView.swift
│   │       ├── ForehandView.swift
│   │       ├── BackhandView.swift
│   │       ├── BodyPositionGuideView.swift
│   │       ├── CountdownOverlayView.swift
│   │       └── JointsOverlayView.swift
│   ├── History/
│   │   ├── ViewModels/
│   │   │   └── HistoryViewModel.swift
│   │   └── Views/
│   │       ├── HistoryScreen.swift
│   │       └── History.swift
│   ├── Summary/
│   │   └── Views/
│   │       └── SummaryView.swift
│   └── Onboarding/
│       └── Views/
│           ├── OnBoardingScreen.swift
│           └── SplashScreen.swift
└── Shared/
    └── Components/
        └── CustomStepper.swift
```

## Models Layer

### StrokeType (unified)
- Keep current enum: `.forehand`, `.backhand`
- Add `.unknown` case for training system compatibility
- Conforms to `Codable` for serialization

### Training Models (from plan, adapted)
- `DetectedBody` — body joint positions with confidence thresholds
- `JointAngle` — calculated angle at a joint (name, degrees, position)
- `BodyJoint` — enum mapping to `VNHumanBodyPoseObservation.JointName`
- `PoseFrame` — timestamped frame with bounding box and joint positions
- `SessionData` — training session with frames, duration, type
- `SessionConfig` — duration presets (30s, 1m, 2m, 5m)
- `SessionState` — state machine: idle → bodyDetected → countdown(Int) → sessionActive → sessionEnded
- `StrokeAnalysisConfig` — per-stroke-type thresholds and scoring weights
- `StrokeAnalysisResult` — detected stroke with amplitude/velocity/angle/smoothness scores
- `SessionAnalysisSummary` — aggregate session data with quality distribution
- `TrainingModule` — training type metadata

### Existing Models (keep)
- `PracticeSetup` — stroke + duration
- `PracticeOverview` — aggregate stats for home screen
- `AppRoute` — navigation routes (add `.training` route)

### Remove
- `PracticeSession` — replaced by `SessionAnalysisSummary`

## Services Layer

| Service | Location | Responsibility |
|---------|----------|---------------|
| `CameraSessionManager` | Training/Services | AVCaptureSession lifecycle, authorization, video output config |
| `PoseDetectionService` | Training/Services | VNDetectHumanBodyPose per frame → DetectedBody |
| `JointAngleCalculator` | Training/Services | Pure function: DetectedBody → [JointAngle] |
| `StrokeAnalysisService` | Training/Services | State machine tracking wrist motion → emits StrokeAnalysisResult |
| `FeedbackEngine` | Training/Services | Pure function: SessionAnalysisSummary → [String] feedback |

### Data Flow
```
CameraSessionManager → PoseDetectionService → TrainingSessionViewModel
                                              ↓
                                    JointAngleCalculator → JointsOverlayView
                                              ↓
                                    StrokeAnalysisService → StrokeAnalysisState
                                              ↓
                                    FeedbackEngine → SessionSummaryOverlay
```

## ViewModels Layer

### AppCoordinator (replaces AppViewModel)
- `@Observable`, manages `NavigationPath`
- Holds `[SessionAnalysisSummary]` session history
- Navigation methods only — no business logic

### HomeViewModel
- Computes `PracticeOverview` from session history
- Exposes `latestSession`, `sessionCount`, `totalMinutes`, `totalSwings`, `accuracyRate`

### TrainingSessionViewModel (from plan)
- `@Observable`, `@MainActor`
- Manages `SessionState` state machine
- Holds `DetectedBody`, `[JointAngle]`, `SessionConfig`, `TrainingType`
- Timer management for countdown and session duration

### StrokeAnalysisState (from plan)
- `@Observable`, `@MainActor`
- Accumulates `[StrokeAnalysisResult]` during session
- `finalizeSession()` produces `SessionAnalysisSummary` + feedback

### HistoryViewModel
- Takes `[SessionAnalysisSummary]` from coordinator
- Filtered/sorted session list
- Computed stats for history display

## Views Layer

### Design Tokens
```swift
// Spacing
enum Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let xxxl: CGFloat = 64
}

// Radius
enum Radius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 20
    static let full: CGFloat = 100
}

// Fonts
extension Font {
    static let ztrokeLargeTitle = Font.system(size: 25, weight: .bold)
    static let ztrokeTitle = Font.system(size: 21, weight: .bold)
    static let ztrokeBody = Font.system(size: 16, weight: .regular)
    static let ztrokeBodySecondary = Font.system(size: 14, weight: .regular)
    static let ztrokeCTALabel = Font.system(size: 17, weight: .semibold)
    static let ztrokeCaption = Font.system(size: 12, weight: .regular)
}
```

### Naming Adaptation (PoonaApp → Ztroke)
- `Color.poonaAccent` → `Color.navy`
- `Color.poonaBackground` → `Color.navy.opacity(0.05)`
- `Color.poonaSecondaryLabel` → `Color.black.opacity(0.7)`
- `.poonaLargeTitle` → `.ztrokeLargeTitle`
- All spacing/radius values use token constants

### Navigation Flow
```
ZtrokeApp
├─ OnBoardingScreen → MainScreen
└─ MainScreen (Home)
   ├─ SummaryView (overview stats)
   ├─ PracticeCount (swing stats)
   ├─ History → HistoryScreen (session list)
   └─ Training Mode
      ├─ Forehand → TrainingSetupView → CameraSessionView → SessionSummaryOverlay
      └─ Backhand → TrainingSetupView → CameraSessionView → SessionSummaryOverlay
```

## Key Decisions

1. **StrokeType**: Keep current enum, add `.unknown` case for compatibility
2. **Design tokens**: Create Ztroke equivalents (Spacing, Radius, Font+Ztroke)
3. **AppViewModel**: Decompose into AppCoordinator + feature ViewModels
4. **History data**: Use real `SessionAnalysisSummary` from training system
5. **PracticeSession**: Remove — replaced by SessionAnalysisSummary
6. **Naming**: Adapt all PoonaApp references to Ztroke conventions
