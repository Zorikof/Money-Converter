import SwiftUI
import Alamofire

struct ConverterView: View {
    @State private var selectedCurrency1 = "AUD"
    @State private var selectedCurrency2 = "EUR"
    @State private var amount: String = ""
    @State private var convertedAmount: String = ""
    @State private var isLoading: Bool = false
    let mainColor = Color(red: 23/255, green: 78/255, blue: 31/255)
    let networkManager = NetworkManager()
    
    var body: some View {
        ZStack {
            Image("MainBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    hideKeyboard()
                }
            
            VStack {
                HStack {
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
                .padding(.top, 40)
                
                Spacer()
                
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.6)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .overlay(
                            VStack(spacing: 20) {
                                Text("Конвертировать:")
                                    .font(.system(size: 36))
                                    .foregroundColor(.black)
                                Spacer()
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: UIScreen.main.bounds.width * 0.4, height: 50)
                                        TextField("Enter amount", text: $amount)
                                            .padding()
                                            .foregroundColor(.black)
                                            .frame(width: UIScreen.main.bounds.width * 0.4, height: 50)
                                    }
                                    
                                    Menu {
                                        ForEach(currencyAbbreviations.keys.sorted(), id: \.self) { key in
                                            Button(action: {
                                                selectedCurrency1 = key
                                            }) {
                                                Text(currencyAbbreviations[key] ?? key)
                                            }
                                        }
                                    } label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(width: UIScreen.main.bounds.width * 0.25, height: 50)
                                            Text(selectedCurrency1)
                                                .foregroundColor(mainColor)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                                
                                Button(action: {
                                    hideKeyboard()
                                    convertCurrency()
                                }) {
                                    Text("Посчитать")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(mainColor)
                                        .cornerRadius(10)
                                }
                                
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: UIScreen.main.bounds.width * 0.4, height: 50)
                                        Text(convertedAmount)
                                            .padding()
                                            .foregroundColor(.black) // Черный цвет текста
                                            .frame(width: UIScreen.main.bounds.width * 0.4, height: 50)
                                    }
                                    
                                    Menu {
                                        ForEach(currencyAbbreviations.keys.sorted(), id: \.self) { key in
                                            Button(action: {
                                                selectedCurrency2 = key
                                            }) {
                                                Text(currencyAbbreviations[key] ?? key)
                                            }
                                        }
                                    } label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(width: UIScreen.main.bounds.width * 0.25, height: 50)
                                            Text(selectedCurrency2)
                                                .foregroundColor(mainColor)
                                        }
                                    }
                                }
                                Spacer()
                                
                                if isLoading {
                                    ProgressView()
                                }
                            }
                            .padding()
                        )
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    func convertCurrency() {
        guard let amount = Double(amount) else {
            self.convertedAmount = "Invalid amount"
            return
        }
        
        isLoading = true
        
        networkManager.fetchCurrencyCourse(from: selectedCurrency1, to: selectedCurrency2) { result in
            isLoading = false
            switch result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let rates = json["data"] as? [String: Double],
                       let rate = rates[selectedCurrency2] {
                        let convertedValue = amount * rate
                        self.convertedAmount = String(format: "%.2f", convertedValue)
                    } else {
                        self.convertedAmount = "Invalid response"
                    }
                } catch {
                    self.convertedAmount = "Failed to parse"
                }
            case .failure(let error):
                self.convertedAmount = "Error: \(error.localizedDescription)"
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ConverterView()
}
