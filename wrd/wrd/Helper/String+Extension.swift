//
//  String+Extension.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 02/01/24.
//

import UIKit

class String_Extension: NSObject {

}

extension String {
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension String {
    func addCountryCode() -> String {
        if self.hasPrefix("91") {
            // Already has the country code, return it as is
            return self
        } else {
            // Add the country code
            return "91" + self
        }
    }
}
