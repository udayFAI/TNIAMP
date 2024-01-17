//
//  OTPGenerate.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 11/01/24.
//

import UIKit
import Foundation

// MARK: - OTPGenerate
struct OTPGenerate: Codable {
    var statusCode, response: String?
    var responseMessage: OTPGenerateResponse?

    enum CodingKeys: String, CodingKey {
        case statusCode, response
        case responseMessage = "response message"
    }
}

// MARK: - ResponseMessage
struct OTPGenerateResponse: Codable {
    var otpDataID: Int?
    enum CodingKeys: String, CodingKey {
        case otpDataID = "otp_data_id"
    }
}
