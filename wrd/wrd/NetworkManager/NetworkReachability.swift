//
//  NetworkReachability.swift
//  eCuleLogiTracker
//
//  Created by KOSURU UDAY SAIKUMAR on 09/09/22.
//

import UIKit
import Foundation
import Alamofire

final class NetworkReachability {
    
    static let shared = NetworkReachability()
    
    private let reachability = NetworkReachabilityManager(host: "www.google.com")!
    
    typealias NetworkReachabilityStatus = NetworkReachabilityManager.NetworkReachabilityStatus
    
    private init() {}
 
    func startListening() {
        reachability.startListening { [weak self] status in
            switch status {
            case .notReachable:
                self?.updateReachabilityStatus(.notReachable)
            case .reachable(let connection):
                self?.updateReachabilityStatus(.reachable(connection))
            case .unknown:
                break
            }
        }
    }
    
    func stopListening() {
        reachability.stopListening()
    }

    private func updateReachabilityStatus(_ status: NetworkReachabilityStatus) {
        switch status {
        case .notReachable:
            debugPrint("@REFLEX----------------------------------------Internet not available --------@NetworkReachability")
//            NotificationCenter.default.post(name: .networkNotReachable, object: nil)
        case .reachable(.ethernetOrWiFi), .reachable(.cellular):
            debugPrint("Internet available")
//            NotificationCenter.default.post(name: .networkReachable, object: nil)
        case .unknown:
            break
        }
    }
    
    /// returns current reachability status
    var isReachable: Bool {
        return reachability.isReachable
    }
    
    /// returns if connected via cellular
    var isConnectedViaCellular: Bool {
        return reachability.isReachableOnCellular
    }
    
    /// returns if connected via wifi
    var isConnectedViaWiFi: Bool {
        return reachability.isReachableOnEthernetOrWiFi
    }
    
    deinit {
        stopListening()
    }
}
