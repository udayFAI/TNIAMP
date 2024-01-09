//
//  WRD+Development.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 08/01/24.
//

import Foundation

enum WRD_Schema {
    private static let infoDict: [String:Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist is not found")
        }
        return dict
    }()
    
    static let root : String = {
        guard let string = WRD_Schema.infoDict["Base_URL"] as? String else {
            fatalError("Base_URL is not found")
        }
        return string
    }()
}
