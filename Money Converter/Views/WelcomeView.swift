import SwiftUI

struct WelcomeView: View {
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("FirstScreenBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                NavigationLink(destination: MainView().onAppear {
                    isFirstLaunch = false
                }) {
                    Image("GetStartedButton")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height / 8)
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height * 0.87)
                }
            }
        }
    }
}

#Preview {
    WelcomeView(isFirstLaunch: .constant(true))
}
