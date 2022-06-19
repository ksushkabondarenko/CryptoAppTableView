import Alamofire

struct APIManager {
    static let instance = APIManager()
    
    enum Constants {
        static let baseURL = "https://rest.coinapi.io/v1"
    }
    enum EndPoints {
        static let exchanges = "/exchanges"
        static let assets = "/assets"
    }
    let header: HTTPHeaders = ["X-CoinAPI-Key": "734ED9F0-CF2F-4CE2-87EA-0017171FDED2", "Accept": "application/json"]
    func test() {
        AF.request(Constants.baseURL + EndPoints.assets,
                   method: .get,
                   parameters: [:],
                   headers: header
        ).responseJSON { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error): print(error)
            }
        }
    }
                               
    func getAllExhanges(_ complition: @escaping([CriptaClientModel]) -> Void) {

        AF.request(Constants.baseURL + EndPoints.assets,
                   method: .get,
                   parameters: [:],
                   headers: header
        ).responseDecodable(of: [CriptaServerModel].self) { response in
            switch response.result {
            case .success(let model):
                let convertedModels = model.map(ModelConverter.instance.convert)
                complition(convertedModels)
            case .failure(let error): print(error)
            }
        }
    }

    private init() {}
}
