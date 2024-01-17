//
//  OTPValidate.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 12/01/24.
//

import UIKit

struct OTPValidate: Codable {
    var statusCode, response: String?
    var responseMessage: OtpValidateResponse?
}

// MARK: - ResponseMessage
struct OtpValidateResponse: Codable {
    var id: Int?
    var serialNo: String?
    var lineDept, village: Int?
    var name: String?
    var mobile: Int?
    var email, createdDate, lat, lon: String?
    var version, subbasin, userStatus: Int?
    var result : String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case serialNo = "SERIAL_NO"
        case lineDept = "LINE_DEPT"
        case village = "VILLAGE"
        case name = "NAME"
        case mobile = "MOBILE"
        case email = "EMAIL"
        case createdDate = "CREATED_DATE"
        case lat, lon, version, subbasin
        case userStatus = "USER_STATUS"
        case result
    }
}
