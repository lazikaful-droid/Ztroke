import SwiftUI

struct OnBoardingPage: Identifiable {
    let id = UUID()
    let imageName: String
}

struct OnBoardingScreen: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @State private var currentIndex: Int = 0

    let pages: [OnBoardingPage] = [
        OnBoardingPage(imageName: "Carousel1"),
        OnBoardingPage(imageName: "Carousel2"),
        OnBoardingPage(imageName: "Carousel3"),
        OnBoardingPage(imageName: "Carousel4"),
        OnBoardingPage(imageName: "Carousel5")
    ]

    var body: some View {
        ZStack {
            Color.navy
                .opacity(0.05)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                TabView(selection: $currentIndex) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                        CarouselCard(imageName: page.imageName)
                            .tag(index)
                            .padding(.horizontal, 16)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 320)
                .padding(.top, 32)

                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex
                                  ? Color.navy
                                  : Color.gray.opacity(0.4))
                            .frame(width: index == currentIndex ? 10 : 8,
                                   height: index == currentIndex ? 10 : 8
                            )
                    }
                }

                VStack(spacing: 12) {
                    Text("Practice makes it perfect")
                        .font(.ztrokeLargeTitle)
                        .foregroundColor(.navy)
                        .multilineTextAlignment(.center)

                    Text("Practice with Zwing to improve\nyour stroke technique nfor better badminton play.")
                        .font(.ztrokeBody)
                        .foregroundColor(.navy)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .padding(.top, 32)
                .padding(.horizontal, 32)

                Spacer()

                Button(action: {
                    isOnboarding = false
                }) {
                    Text("Get Started")
                        .font(.ztrokeCTALabel)
                        .padding(.horizontal, 120)
                        .padding(.vertical, 15)
                        .background(Color.navy)
                        .foregroundColor(.white)
                        .cornerRadius(Radius.full)
                }
            }
            .padding(.bottom, -20)
        }
    }
}

private struct CarouselCard: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 250)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: Radius.lg))
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    OnBoardingScreen()
}
