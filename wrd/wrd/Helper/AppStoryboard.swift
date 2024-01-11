//
//  AppStoryboard.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 09/01/24.
//

import UIKit

enum AppStoryboard: String {
    case Main
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass : T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyBoardID) as? T else {
            fatalError("ViewController with identifier \(storyBoardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    // MARK:- OTP View controller
    func showOTPVC() {
        let otpVC = OTPViewController.instantiate(fromAppStoryboard: .Main)
        otpVC.modalPresentationStyle = .overCurrentContext
        otpVC.modalTransitionStyle   = .crossDissolve
        self.present(otpVC, animated: true, completion: nil)
    }
    
    func showDashboardVC() {
        let dashboardVC = DashboardViewController.instantiate(fromAppStoryboard: .Main)
        dashboardVC.modalPresentationStyle = .overCurrentContext
        dashboardVC.modalTransitionStyle   = .crossDissolve
        self.present(dashboardVC, animated: true, completion: nil)
    }
    
    func showLoginVC() {
        let loginVC = ViewController.instantiate(fromAppStoryboard: .Main)
        loginVC.modalPresentationStyle = .overCurrentContext
        loginVC.modalTransitionStyle   = .crossDissolve
        self.present(loginVC, animated: true, completion: nil)
    }
    
    func showDepartmentDetails(name: String) {
        let detailsVC = DepartmentDetailsViewController.instantiate(fromAppStoryboard: .Main)
        detailsVC.departmentName = name
        detailsVC.modalPresentationStyle = .overCurrentContext
        detailsVC.modalTransitionStyle   = .crossDissolve
        self.present(detailsVC, animated: true, completion: nil)
    }
}
