import SwiftUI
import Alamofire

class NetworkManager {
        
    func fetchAllData(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = "https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_5XSII1pW4i6v2b9kt0A0aZlOVWKEjgFbMMIXet1y&currencies=EUR%2CJPY%2CBGN%2CCZK%2CDKK%2CGBP%2CHUF%2CPLN%2CRON%2CSEK%2CCHF%2CISK%2CNOK%2CHRK%2CRUB%2CTRY%2CAUD%2CBRL%2CCAD%2CCNY%2CHKD%2CIDR%2CILS%2CINR%2CKRW%2CMXN%2CMYR%2CNZD%2CPHP%2CSGD%2CTHB%2CZAR#"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCurrencyCourse(from: String, to: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = "https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_5XSII1pW4i6v2b9kt0A0aZlOVWKEjgFbMMIXet1y&currencies=\(to)&base_currency=\(from)"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


