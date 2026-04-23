import SwiftUI

struct HistoryScreen: View {
    let viewModel: HistoryViewModel

    var body: some View {
        ZStack {
            Color.navy
                .opacity(0.08)
                .ignoresSafeArea()

            VStack {
                Text("History")
                    .font(.ztrokeTitle)
                    .foregroundColor(.black)
                    .padding(.trailing, 250)

                ZStack {
                    RoundedRectangle(cornerRadius: Radius.lg)
                        .frame(width: 340, height: 700)
                        .foregroundStyle(Color.navy)
                        .opacity(0.08)

                    if viewModel.isEmpty {
                        VStack {
                            Spacer()
                            Text("No practice sessions yet")
                                .font(.ztrokeBodySecondary)
                                .foregroundColor(.black)
                                .opacity(0.6)
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(viewModel.sessions) { session in
                                    SessionRow(session: session, viewModel: viewModel)

                                    if session.id != viewModel.sessions.last?.id {
                                        Divider()
                                            .frame(height: 1)
                                    }
                                }
                            }
                        }
                        .frame(width: 340, height: 700)
                        .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
                    }
                }
            }
        }
    }
}

private struct SessionRow: View {
    let session: SessionAnalysisSummary
    let viewModel: HistoryViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.formattedDate(session.date))
                .font(.ztrokeCaption)
                .foregroundColor(.black)
                .padding(.trailing, 180)

            Text(viewModel.formattedDuration(session))
                .font(.system(size: 12, weight: .bold, design: .default))
                .foregroundColor(.black)
                .padding(.trailing, 250)
                .padding(.bottom, 10)

            HStack {
                Text("Swings: \(session.totalStrokes)")
                    .font(.ztrokeCaptionBold)
                    .foregroundColor(.black)
                    .padding(.trailing, 70)

                Text("Perfect: \(session.qualityDistribution.perfect)")
                    .font(.ztrokeCaptionBold)
                    .foregroundColor(.black)
                    .padding(.trailing, 35)

                Text("Miss: \(session.qualityDistribution.miss)")
                    .font(.ztrokeCaptionBold)
                    .foregroundColor(.black)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
    }
}

#Preview {
    HistoryScreen(viewModel: HistoryViewModel(sessions: []))
}
