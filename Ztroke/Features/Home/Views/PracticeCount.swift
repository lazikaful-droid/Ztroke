import SwiftUI

struct PracticeCount: View {
    let viewModel: HomeViewModel

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: Radius.lg)
                    .frame(width: 165, height: 140)
                    .foregroundStyle(Color.navy)
                    .opacity(0.08)

                VStack(alignment: .leading) {
                    Text("Practice Count")
                        .font(.ztrokeCaptionBold)
                        .foregroundColor(.black)
                        .padding(.top, 15)
                        .padding(.bottom, 10)
                        .padding(.trailing, 35)

                    Text("Total Swing")
                        .font(.ztrokeCaption)
                        .foregroundColor(.black)
                        .opacity(0.8)

                    Text("\(viewModel.totalSwings)x")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(.black)

                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.navy)
                            .opacity(0.8)

                        Text("\(Int(viewModel.accuracyRate * 100))%")
                            .font(.ztrokeCaptionBold)
                            .foregroundColor(.black)

                        Image(systemName: "wrongwaysign.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.navy)
                            .padding(.leading, 20)

                        Text("\(Int((1 - viewModel.accuracyRate) * 100))%")
                            .font(.ztrokeCaptionBold)
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 10)
                }
            }

            ZStack {
                RoundedRectangle(cornerRadius: Radius.lg)
                    .frame(width: 165, height: 140)
                    .foregroundStyle(Color.navy)
                    .opacity(0.08)

                VStack(alignment: .leading) {
                    Text("Accuracy")
                        .font(.ztrokeCaptionBold)
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                        .padding(.trailing, 35)

                    HStack {
                        Image(systemName: "location.north.fill")
                            .resizable()
                            .frame(width: 35, height: 45)
                            .foregroundColor(.navy)
                            .opacity(0.4)

                        VStack {
                            Text("Average Rate")
                                .font(.ztrokeCaptionBold)
                                .foregroundColor(.black)
                                .opacity(0.8)

                            Text("\(Int(viewModel.accuracyRate * 100))%")
                                .font(.system(size: 40, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 15)
                }
            }
        }
    }
}

#Preview {
    PracticeCount(viewModel: HomeViewModel(sessions: []))
}
