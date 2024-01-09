//
//  PrintLog.swift
//  ecom
//
//  Created by Kosuru Uday Saikumar on 03/01/24.
//

import UIKit

class PrintLog: NSObject {
    class func info(_ message: String)  {
        PrintLog.writeLog(logType: "INFO", message: message)
    }
    class func error(_ message: String)  {
        PrintLog.writeLog(logType: "ERROR", message: message)
    }
    class func success(_ message: String)  {
        PrintLog.writeLog(logType: "SUCCESS", message: message)
    }
    class func warning(_ message: String)  {
        PrintLog.writeLog(logType: "WARNING", message: message)
    }
    class func debug(_ message: String)  {
        PrintLog.writeLog(logType: "DEBUG", message: message)
    }
    class func secure(_ message: String)  {
        PrintLog.writeLog(logType: "SECURE", message: message)
    }
    class func request(_ message: String)  {
        PrintLog.writeLog(logType: "REQUEST", message: message)
    }
    class func response(_ message: String)  {
        PrintLog.writeLog(logType: "RESPONSE", message: message)
    }
    
    private class func writeLog(logType: String, message: String) {
        print(  String(format: "[%@] : %@", logType,message)  )
       // NSLog("[%@] : %@", logType,message)
    }
}
