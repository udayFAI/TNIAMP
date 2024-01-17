//
//  eClueAPIManager.swift
//  eCuleLogiTracker
//
//  Created by KOSURU UDAY SAIKUMAR on 09/09/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIManager: NSObject {
    
    static let shared = APIManager()
    
    func request<T: Decodable>(parameters: [String:String],
                               responseObjectType: T.Type,
                               success: @escaping (OTPGenerate) -> Void,
                               failure: @escaping (AFError) -> Void, translateJSON: @escaping (Bool) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIEnvironment.staging.scheme
        components.path = APIHost.staging.host + endPathPoints.otpgenerator
       // components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value.replacingOccurrences(of: "%20", with: "")) }

        guard let url = components.url?.absoluteString.removingPercentEncoding else { return }
        AF.request(url, method: .get, parameters:parameters, encoding: URLEncoding.default, headers: [:], interceptor: nil).validate().responseDecodable(of: OTPGenerate.self) { response in
            switch response.result {
            case .success(let data):
                LoginViewModel.shared.modelData = data
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func requestOTPValidte<T: Decodable>(parameters: [String:String],
                               responseObjectType: T.Type,
                               success: @escaping (OTPValidate) -> Void,
                               failure: @escaping (AFError) -> Void, translateJSON: @escaping (Bool) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIEnvironment.staging.scheme
        components.path = APIHost.staging.host + endPathPoints.otpValidate
       // components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value.replacingOccurrences(of: "%20", with: "")) }

        guard let url = components.url?.absoluteString.removingPercentEncoding else { return }
        AF.request(url, method: .get, parameters:parameters, encoding: URLEncoding.default, headers: [:], interceptor: nil).validate().responseDecodable(of: OTPValidate.self) { response in
            switch response.result {
            case .success(let data):
                OTPViewModel.shared.modelData = data
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func requestLookUpSubBasin<T: Decodable>(tag: Int, parameters: [String:String],
                               responseObjectType: T.Type,
                               success: @escaping ([SubBasin]) -> Void,
                               failure: @escaping (AFError) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIEnvironment.staging.scheme
        components.path = APIHost.staging.host + endPathPoints.lookup
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url?.absoluteString.removingPercentEncoding else { return }
        AF.request(url, method: .get, parameters:[:], encoding: URLEncoding.default, headers: [:], interceptor: nil).validate().responseDecodable(of: [SubBasin].self) { response in
            switch response.result {
            case .success(let data):
                DashboardViewModel.shared.sub_Basin = data
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func requestLookUpDistrict<T: Decodable>(tag: Int, parameters: [String:String],
                               responseObjectType: T.Type,
                               success: @escaping ([District]) -> Void,
                               failure: @escaping (AFError) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIEnvironment.staging.scheme
        components.path = APIHost.staging.host + endPathPoints.lookup
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url?.absoluteString.removingPercentEncoding else { return }
        AF.request(url, method: .get, parameters:[:], encoding: URLEncoding.default, headers: [:], interceptor: nil).validate().responseDecodable(of: [District].self) { response in
            switch response.result {
            case .success(let data):
                DashboardViewModel.shared.district = data
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func requestLookUpBlock<T: Decodable>(parameters: [String:String],
                               responseObjectType: T.Type,
                               success: @escaping ([Block_]) -> Void,
                               failure: @escaping (AFError) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIEnvironment.staging.scheme
        components.path = APIHost.staging.host + endPathPoints.lookup
       // components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value.replacingOccurrences(of: "%20", with: "")) }

        guard let url = components.url?.absoluteString.removingPercentEncoding else { return }
        AF.request(url, method: .get, parameters:parameters, encoding: URLEncoding.default, headers: [:], interceptor: nil).validate().responseDecodable(of: [Block_].self) { response in
            switch response.result {
            case .success(let data):
                DashboardViewModel.shared.block = data
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }

    func requestLookUpVillage<T: Decodable>(parameters: [String:String],
                               responseObjectType: T.Type,
                               success: @escaping ([Village]) -> Void,
                               failure: @escaping (AFError) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = APIEnvironment.staging.scheme
        components.path = APIHost.staging.host + endPathPoints.lookup
       // components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value.replacingOccurrences(of: "%20", with: "")) }

        guard let url = components.url?.absoluteString.removingPercentEncoding else { return }
        AF.request(url, method: .get, parameters:parameters, encoding: URLEncoding.default, headers: [:], interceptor: nil).validate().responseDecodable(of: [Village].self) { response in
            switch response.result {
            case .success(let data):
                DashboardViewModel.shared.village = data
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
