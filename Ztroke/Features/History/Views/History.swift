import SwiftUI

struct History: View {
    let session: SessionAnalysisSummary?

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        return formatter
    }()

    private func minutesFromSession(_ session: SessionAnalysisSummary) -> Int {
        let lastTimestamp = session.strokes.last?.timestamp ?? 0
        return Int(lastTimestamp) / 60
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Radius.lg)
                .frame(width: 340, height: 140)
                .foregroundStyle(Color.navy)
                .opacity(0.08)

            VStack(alignment: .leading) {
                HStack {
                    Text("History")
                        .font(.ztrokeCaptionBold)
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                        .padding(.trailing, 150)

                    Image(systemName: "chevron.right.circle")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.black)
                        .padding(.leading, 90)
                }
                .padding(.bottom, 10)

                if let session {
                    Text(dateFormatter.string(from: session.date))
                        .font(.ztrokeCaption)
                        .opacity(0.8)
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                        .padding(.trailing, 150)

                    Text("\(minutesFromSession(session)) Minutes")
                        .font(.system(size: 30, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                        .padding(.trailing, 150)
                        .padding(.bottom, 5)

                    Text("Swing: \(session.totalStrokes)")
                        .font(.ztrokeCaptionBold)
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                        .padding(.trailing, 150)
                        .padding(.bottom, 5)

                    HStack {
                        Text("Perfect: \(session.qualityDistribution.perfect)")
                            .font(.ztrokeCaption)
                            .foregroundColor(.black)
                            .padding(.leading, 10)

                        Text("Miss: \(session.qualityDistribution.miss)")
                            .font(.ztrokeCaption)
                            .foregroundColor(.black)
                            .padding(.leading, 150)
                    }
                } else {
                    Text("No sessions yet")
                        .font(.ztrokeCaption)
                        .foregroundColor(.black)
                        .opacity(0.6)
                        .padding(.leading, 10)
                }
            }
        }
    }
}

#Preview {
    History(session: nil)
}
