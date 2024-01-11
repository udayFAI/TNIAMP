//
//  CameraGallery.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 26/12/23.
//

import UIKit
import AssetsLibrary
import Photos
import PhotosUI

class CameraPermisson: NSObject{
    static let sharedInstance = CameraPermisson()
    
    public typealias imageComplition = ( _ image : UIImage?,_ strName : String?,_ error : Error?, _ fileURL: URL?) -> Void
    var complation = {( _ image : UIImage?,_ strName : String?,_ error : Error?, fileURL: URL?) -> Void in  }
    
    override init() {
        super.init()
    }
    
    func openCamara(_ vc : UIViewController, isEdit : Bool,_ imageComplition : @escaping imageComplition){
        self.checkPermissionForCamera { [weak self] isAuthorized in
            guard let `self` = self else { return }
            if isAuthorized {
                let picker = UIImagePickerController()
                picker.delegate = self
                if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
                    picker.sourceType = UIImagePickerController.SourceType.camera
                    picker.allowsEditing = isEdit
                    picker.isEditing = isEdit
                    vc.present(picker, animated: true, completion: nil)
                    self.complation = imageComplition
                }
                else {
                    DispatchQueue.main.async {
                        imageComplition(nil,nil,nil, nil)
                        AlertHelper.showAlert(title: "Utils", message: "You don't have camera", viewController: vc)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    AlertHelper.showAlertWithYesNo(title: "Utils", message: "Please allow access to camera permission.", button1: "Settings", noButton: "Cancel", viewController: vc) {
                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: { (_ ) in
                        })
                    } noAction: {
                        
                    }
                    imageComplition(nil,nil,nil, nil)
                }
            }
        }
    }

    func checkPermissionForCamera(authorizedRequested : @escaping (_ isAuthorized:Bool) -> Swift.Void) -> Void {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            DispatchQueue.main.async {
                authorizedRequested(true)
            }
        }
        else if AVCaptureDevice.authorizationStatus(for: .video) ==  .denied || AVCaptureDevice.authorizationStatus(for: .video) ==  .restricted {
            //restricted
            DispatchQueue.main.async {
                authorizedRequested(false)
            }
        }else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    DispatchQueue.main.async {
                        authorizedRequested(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        authorizedRequested(false)
                    }
                }
            })
        }
    }
}

extension CameraPermisson : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker .dismiss(animated: true, completion: nil)
        var image : UIImage?
        var imageUrl: NSURL!
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            image = img
        }else if let originalImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image = originalImg
        }else{
            image = nil
        }
        var strImageName = ""
        if (info[.imageURL] as? NSURL) != nil {
            imageUrl = info[.imageURL] as? NSURL
            let imageName :String! = imageUrl.pathExtension
            strImageName = "\(Int(Date().timeIntervalSince1970))."
            strImageName = strImageName.appending(imageName)
        }else{
            strImageName = "\(Int(Date().timeIntervalSince1970)).png"
        }
        guard image != nil else {
            DispatchQueue.main.async {
                self.complation(nil,nil,"enable to get image" as? Error, nil)
            }
            return
        }
        DispatchQueue.main.async {
            self.complation(image,strImageName,nil, imageUrl as URL?)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker .dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            self.complation(nil,nil,nil, nil)
        }
    }
}
