import SwiftUI

struct SettingsView: View {
    let appId = "YOUR_APP_ID" // Замените на ваш фактический идентификатор приложения перед публикацией
    let email = "your.email@example.com" // Замените на вашу почту
    let privacyPolicyURL = "https://yourprivacypolicy.com" // Замените на вашу ссылку на политику конфиденциальности
    
    @State private var showCopyMessage = false
    
    var body: some View {
        ZStack {
            Image("MainBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: .all)
            
            GeometryReader { geometry in
                VStack(spacing: 32) {
                    Button(action: {
                        if let url = URL(string: privacyPolicyURL) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Image("PrivacyPolicyButton")
                            .resizable()
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.07)
                    }
                    
                    Text("Rate us!")
                        .foregroundColor(.black)
                        .font(.title)
                    
                    Button(action: {
                        if let url = URL(string: "https://apps.apple.com/app/id\(appId)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Image("RateStarsLabel")
                            .resizable()
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.08)
                    }
                    
                    Button(action: {
                        UIPasteboard.general.setValue(email, forPasteboardType: "public.plain-text")
                        showCopyMessage = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showCopyMessage = false
                        }
                    }) {
                        Image("MessageLabel")
                            .resizable()
                            .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.1)
                    }
                }
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.6)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
                .padding()
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                if showCopyMessage {
                    Text("Email скопирован!")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(1))
                        .cornerRadius(10)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .transition(.opacity)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
