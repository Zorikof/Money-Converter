import SwiftUI

struct CurrenciesView: View {
    @StateObject private var controller = CurrenciesController()
    @State private var isRefreshing = false
    let mainColor = Color(red: 23/255, green: 78/255, blue: 31/255)
    
    var body: some View {
        ZStack {
            Image("MainBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: .all)
            
            VStack(spacing: 0) {
                if controller.isLoading && !isRefreshing {
                    ProgressView("Loading...")
                        .foregroundColor(.white)
                } else if controller.networkError {
                    Text("Для отображения курсов валют необходимо подключение к интернету")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.horizontal)
                } else if let currencyData = controller.currencyData {
                    HStack {
                        Text("1 USD к:")
                            .foregroundColor(mainColor)
                            .opacity(0.8)
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .padding(.leading)
                        Spacer()
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width / 10, height: UIScreen.main.bounds.width / 10)
                                .foregroundColor(mainColor)
                                .opacity(0.8)
                                .padding(.trailing)
                        }
                    }
                    .padding(.top, 20)
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(currencyData.data.sorted { (lhs, rhs) -> Bool in
                                let lhsName = currencyAbbreviations[lhs.key] ?? lhs.key
                                let rhsName = currencyAbbreviations[rhs.key] ?? rhs.key
                                return lhsName < rhsName
                            }, id: \.key) { key, value in
                                HStack {
                                    Image(lowerCase(key))
                                        .resizable()
                                        .frame(width: 60, height: 40)
                                    Text(currencyAbbreviations[key] ?? key)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text(String(format: "%.2f", value))
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 10)
                        .refreshable {
                            isRefreshing = true
                            controller.fetchAllData {
                                isRefreshing = false
                            }
                        }
                    }
                    .padding(.bottom, bottomPadding())
                } else {
                    Text("No data")
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 10)
        }
        .onAppear {
            controller.fetchAllData()
        }
    }
    
    func bottomPadding() -> CGFloat {
        if UIScreen.main.bounds.height > 800 {
            return 10 // Devices without a Home button
        } else {
            return 50 // Devices with a Home button
        }
    }
}

#Preview {
    CurrenciesView()
}
