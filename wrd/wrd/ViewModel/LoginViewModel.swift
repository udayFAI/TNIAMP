//
//  LoginViewModel.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 02/01/24.
//

import UIKit
import Alamofire

protocol OTPGeneratorDelegate: AnyObject {
     func responseOTP(response: OTPGenerate)
    func failureOTP(status: Bool)
}

class LoginViewModel: NSObject {
    var validate: Validate =  Validate()
    var mobileStatus = false
    weak var delegate: OTPGeneratorDelegate?
    
    func textFieldCharactersValidate(text: String) -> Bool {
        return validate.isDigitsAcceptDeleteBackSpace(text: text, maxLength: 10)
    }
    
    func isMobileStatus() -> Bool {
        return mobileStatus
    }
    
    static let shared = LoginViewModel()
    var modelData: OTPGenerate!

    // func userSignIn(_ signIn: [String:String], callback:@escaping(_ status: Bool, _ statusCode: Int)->()) {
    func userSignIn(_ signIn: [String:String]) {
        APIManager.shared.request(parameters: signIn, responseObjectType: OTPGenerate.self) { [self] successModel in
            debugPrint("network request status success ----------", successModel)
            delegate?.responseOTP(response: successModel)
        } failure: { [self] failureModel in
            debugPrint("network request status failure ----------", failureModel)
            delegate?.failureOTP(status: false)
        } translateJSON: { [self] _ in
            debugPrint("network request status translate ----------", false)
            delegate?.failureOTP(status: false)
        }
    }
}

//class NetworkManager {
//    static func fetchData(scheme: String,
//                          host: String,
//                          mainPath: String,
//                          subPath: String,
//                          parameters: [String: String],
//                          completion: @escaping (Result<Data, Error>) -> Void) {
////        var components = URLComponents()
////        components.scheme = scheme
////        components.host = host
////        components.path = mainPath + subPath
////        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
////
////        guard let url = components.url else { return }
//
//        AF.request("https://y18ft8td4k.execute-api.ap-south-1.amazonaws.com/dev/api/otp/generate?phone=8465969964&message=OTPis&digits=4", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: [:], interceptor: nil).responseJSON { (response) in
//                    if let status = response.response?.statusCode{
//                        do {
//                            let result = try response.result.get()
//                            if let data = result as? [String:String]{
//                                print(data)
//                               
//                            }
//                        } catch{
//                           
//                        }
//                    }else{
//                        
//                    }
//                }
//        
//        AF.request("https://y18ft8td4k.execute-api.ap-south-1.amazonaws.com/dev/api/otp/generate?phone=8465969964&message=OTPis&digits=4").responseData { response in
//            switch response.result {
//                case .success(let data):
//                    completion(.success(data))
//                case .failure(let error):
//                    completion(.failure(error))
//            }
//        }
//    }
//}
