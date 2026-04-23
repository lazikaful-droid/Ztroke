import SwiftUI

struct CameraSetUpScreen: View {
    let coordinator: AppCoordinator

    var body: some View {
        NavigationStack {
            ZStack {
                Color.navy
                    .opacity(0.05)
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.navy)

                    Text("Camera Set Up")
                        .font(.ztrokeTitle)
                        .padding(.bottom, 30)

                    SetupInfoRow(
                        icon: "tennis.racket.circle",
                        title: "Encouragement",
                        description: "Utilise racket arc will improve for best experience\nand your training."
                    )

                    SetupInfoRow(
                        icon: "iphone.circle",
                        title: "Phone Position",
                        description: "Positioning your phone in an ideal height that fit\nwith your body."
                    )

                    SetupInfoRow(
                        icon: "accessibility",
                        title: "Body Distance",
                        description: "Positioning yourself in an ideal distance in front of\nyour phone with the full body and racket arc fit\nwithin the frame."
                    )

                    SetupInfoRow(
                        icon: "circle.circle",
                        title: "Start & End Session",
                        description: "Tap record to begin the practice. The App will auto-\ndetects your swing angle during practice. Tap again\nto finish session and will direct you to the recap of\nyour practice."
                    )

                    Spacer()

                    NavigationLink {
                        ForehandView().navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Start Session")
                            .font(.ztrokeCTALabel)
                            .padding(.horizontal, 122)
                            .padding(.vertical, 15)
                            .background(Color.navy)
                            .foregroundColor(.white)
                            .cornerRadius(Radius.full)
                    }
                }
            }
        }
    }
}

private struct SetupInfoRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Radius.sm)
                .frame(width: 370, height: 70)
                .foregroundStyle(Color.gray)
                .opacity(0.3)

            HStack {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.navy)

                VStack {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .padding(.trailing, 160)
                        .padding(.bottom, 3)

                    Text(description)
                        .font(.ztrokeCaption)
                }
            }
        }
    }
}

#Preview {
    CameraSetUpScreen(coordinator: AppCoordinator())
}
