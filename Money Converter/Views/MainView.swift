import SwiftUI

struct MainView: View {
    
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(red: 23/255, green: 78/255, blue: 31/255, alpha: 0.8)
    }
    
    var body: some View {
        NavigationView {
            TabView {
                CurrenciesView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Валюты")
                    }
                
                ConverterView()
                    .tabItem {
                        Image(systemName: "rublesign.circle")
                        Text("Конвертер")
                    }
            }
            .accentColor(Color.white)
        }
    }
}

#Preview {
    MainView()
}
