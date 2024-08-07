import SwiftUI

class CurrenciesController: ObservableObject {
    @Published var currencyData: CurrencyDataResponse?
    @Published var isLoading: Bool = false
    @Published var networkError: Bool = false

    func fetchAllData(completion: @escaping () -> Void = {}) {
        isLoading = true
        networkError = false
        NetworkManager().fetchAllData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(CurrencyDataResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.currencyData = decodedData
                        self.isLoading = false
                        completion()
                    }
                } catch {
                    print("Error decoding JSON:", error)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        completion()
                    }
                }
            case .failure(let error):
                print("Error:", error)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.networkError = true
                    completion()
                }
            }
        }
    }
}
