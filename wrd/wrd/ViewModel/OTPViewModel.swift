//
//  OTPViewModel.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 09/01/24.
//

import UIKit

protocol OTPValidatorDelegate: AnyObject {
     func responseOTP(response: OTPValidate)
    func failureOTP(status: Bool)
}

class OTPViewModel: NSObject {
    var validate: Validate =  Validate()
    static let shared = OTPViewModel()
    var modelData: OTPValidate!
    
    weak var delegate: OTPValidatorDelegate?
    
    func userOTPValidate(_ signIn: [String:String]) {
        APIManager.shared.requestOTPValidte(parameters: signIn, responseObjectType: OTPValidate.self) { [self] successModel in
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
