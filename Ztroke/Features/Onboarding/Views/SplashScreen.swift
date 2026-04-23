import SwiftUI

struct SplashScreen: View {
    @State var isActive: Bool = false

    var body: some View {
        VStack {
            if self.isActive {
                OnBoardingScreen()
            } else {
                ZStack {
                    Color.navy
                        .opacity(0.1)
                        .ignoresSafeArea()

                    VStack {
                        Spacer()
                        Image("Zwing")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
