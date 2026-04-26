import SwiftUI

struct SummaryView: View {
    let viewModel: HomeViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Radius.lg)
                .frame(width: 340, height: 160)
                .foregroundStyle(Color.navy)
                .opacity(0.08)

            VStack(alignment: .leading, spacing: 10) {
                Text("Practice")
                    .font(.ztrokeCaptionBold)
                    .foregroundStyle(.black)
                    .padding(.leading, 20)
                    .padding(.top, 75)

                HStack {
                    Image(systemName: "baseball.diamond.bases")
                        .resizable()
                        .frame(width: 140, height: 100)
                        .foregroundStyle(.navy)
                        .opacity(0.4)
                        .padding(.leading, 40)
                        .padding(.bottom, 70)
                        .padding(.trailing, 20)

                    VStack {
                        Text("\(viewModel.sessionCount)x")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .monospaced()
                            .padding(.trailing, 90)
                            .foregroundStyle(.black)

                        Text("Practice Committed")
                            .font(.ztrokeCaption)
                            .foregroundStyle(.black)
                            .padding(.trailing, 30)

                        Text("\(viewModel.totalSwings)")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .monospaced()
                            .padding(.top, 1)
                            .padding(.trailing, 95)
                            .padding(.leading, -5)
                            .foregroundStyle(.black)

                        Text("Total Swings")
                            .font(.ztrokeCaption)
                            .foregroundStyle(.black)
                            .padding(.trailing, 48)
                    }
                    .padding(.leading, -15)
                    .padding(.bottom, 75)
                }
            }
        }
    }
}

#Preview {
    SummaryView(viewModel: HomeViewModel(sessions: []))
}
