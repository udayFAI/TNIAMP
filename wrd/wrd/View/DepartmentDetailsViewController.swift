//
//  DepartmentDetailsViewController.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 09/01/24.
//

import UIKit
import CoreLocation
import FSCalendar

class DepartmentDetailsViewController: UIViewController {

    @IBOutlet weak var departTitle: UILabel!
    
    @IBOutlet weak var dropDown1: DropDownView!
    @IBOutlet weak var subBasinView: DropDownView!
    @IBOutlet weak var districtDDView: DropDownView!
    @IBOutlet weak var blockDDView: DropDownView!
    @IBOutlet weak var villageDDView: DropDownView!
    @IBOutlet weak var componentDDView: DropDownView!
    @IBOutlet weak var subComponentDDView: DropDownView!
    @IBOutlet weak var stagesDDView: DropDownView!
    @IBOutlet weak var genderDDView: DropDownView!
    @IBOutlet weak var categoryDDView: DropDownView!
    @IBOutlet weak var interventionTypeDDView: DropDownView!
    
    @IBOutlet weak var camera2BtnOutlet: UIButton!
    @IBOutlet weak var camera1BtnOutlet: UIButton!
    
    @IBOutlet weak var checkboxBtnOutlet: UIButton!
    @IBOutlet weak var calendarTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var surveyTextField: UITextField!
    @IBOutlet weak var landAreaTextField: UITextField!
    @IBOutlet weak var tankNameTextField: UITextField!
    @IBOutlet weak var remarkTextfield: UITextField!
    
    let centeredDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [centeredDropDown]
    }()
    
    var dropDownArray = [String]()
    var departmentName = ""
    var dropDownViews = [DropDownView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        departTitle.text = departmentName
        
        configureDropDownView(&dropDown1, tag: 1, placeholder: "Phase")
        configureDropDownView(&subBasinView, tag: 2, placeholder: "Sub Basin")
        configureDropDownView(&districtDDView, tag: 3, placeholder: "District")
        configureDropDownView(&blockDDView, tag: 4, placeholder: "Block")
        configureDropDownView(&villageDDView, tag: 5, placeholder: "Village")
        configureDropDownView(&componentDDView, tag: 6, placeholder: "Component")
        configureDropDownView(&subComponentDDView, tag: 7, placeholder: "Sub Component")
        configureDropDownView(&stagesDDView, tag: 8, placeholder: "Stages")
        configureDropDownView(&genderDDView, tag: 9, placeholder: "Gender")
        configureDropDownView(&categoryDDView, tag: 10, placeholder: "Category")
        configureDropDownView(&interventionTypeDDView, tag: 11, placeholder: "Intervention Type (Optional)")
        
        dropDownViews = [
            dropDown1, subBasinView, districtDDView, blockDDView, villageDDView,
            componentDDView, subComponentDDView, stagesDDView, genderDDView, categoryDDView, interventionTypeDDView
        ]
           
        dropDowns.forEach { $0.dismissMode = .manual }
//        dropDowns.forEach { $0.direction = .bottom }
    }
    
    func dropDownHandler(text: inout UITextField, ddView: inout DropDownView) {
        centeredDropDown.anchorView = ddView
        centeredDropDown.bottomOffset = CGPoint(x: 0, y: ddView.frame.size.height)
        let capturedText = text // Capture the current value of 'text'
        let capturedArrow = ddView
        centeredDropDown.dataSource = dropDownArray
        centeredDropDown.selectionAction = { [self, capturedText, capturedArrow] (index, item) in
            print("Item ", item)
            capturedArrow.arrowOutlet.isSelected.toggle()
            
            let currentTag = capturedText.tag
            removeTextFields(from: currentTag)
            centeredDropDown.hide()
            if capturedText.text != item {
                capturedText.text = item
                // TODO: remove next text field
            } else {
                // TODO: do not remove next text field
            }
        }
    }
    
    func configureDropDownView(_ dropDownView: inout DropDownView, tag: Int, placeholder: String) {
        dropDownView.textField.tag = tag
        dropDownView.textField.placeholder = placeholder
        dropDownView.dropDownDelegate = self
    }
    
    func removeTextFields(from index: Int) {
        for i in index..<dropDownViews.count {
            let text = dropDownViews[safe: i]?.textField.text
            if text != "" {
                dropDownViews[safe: i]?.textField.text = ""
            }
        }
    }
    
    @IBAction func textCheckBoxHandler(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func backHandler(_ sender: Any) {
        showDashboardVC()
    }
    
    @IBAction func calendarHandler(_ sender: Any) {
        let popupViewController = CalendarViewController()
        popupViewController.calendarDelegate = self
        popupViewController.previousMonth = 1
        popupViewController.modalPresentationStyle = .custom
     //   popupViewController.transitioningDelegate = self
        popupViewController.appear(sender: self)
    }
    
    @IBAction func cameraHandler(_ sender: UIButton) {
        CameraPermisson.sharedInstance.openCamara(self, isEdit: true) { [self] image, strName, error, fileUrl  in
            guard let imgProfile = image, let imageName = strName else{
                return
            }
            if sender.tag == 0 {
                camera1BtnOutlet.setImage(imgProfile, for: .normal)
                 // TODO: left side image
            } else {
                camera2BtnOutlet.setImage(imgProfile, for: .normal)
                // TODO: Right side image.
            }
        }
        LocationManager.shared.getLocation { [self] (location:CLLocation?, error:NSError?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let location = location else {
                return
            }
            print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
        }
    }
    
    @IBAction func SubmitHandler(_ sender: Any) {
        if areAllTextFieldsFilled() {
            print("All fields are filled!")
        } else if camera2BtnOutlet.imageView?.image === camera2BtnOutlet.image(for: .normal) {
            AlertHelper.showAlert(title: "TNIAMP", message: "Camera photo is missing", viewController: self)
            // No custom image set, only default image
        } else if camera1BtnOutlet.imageView?.image === camera1BtnOutlet.image(for: .normal) {
            AlertHelper.showAlert(title: "TNIAMP", message: "Camera photo is missing", viewController: self)
            // No custom image set, only default image
        } else {
            AlertHelper.showAlert(title: "TNIAMP", message: "Please enter all the fields", viewController: self)
        }
    }
    
    func areAllTextFieldsFilled() -> Bool {
        let textFields = [
            dropDown1.textField, subBasinView.textField, districtDDView.textField,
            blockDDView.textField, villageDDView.textField, componentDDView.textField,
            subComponentDDView.textField, stagesDDView.textField, calendarTextField, nameTextField, mobileTextField, genderDDView.textField,
            categoryDDView.textField, surveyTextField, landAreaTextField, tankNameTextField, remarkTextfield, interventionTypeDDView.textField
        ]
        return textFields.allSatisfy { $0?.text?.isEmpty == false }
    }
}

extension DepartmentDetailsViewController: dropDownSelectDeleage {
    func dropDownSelect(tag: Int) {
        switch tag {
        case 1:
            dropDownArray = [
                "Phase 1",
                "Phase 2",
                "Phase 3",
                "Phase 4"
            ]
            dropDownHandler(text: &dropDown1.textField, ddView: &dropDown1)
            centeredDropDown.show()
        case 2:
            dropDownArray = [
                "Phase 1",
                "Phase 2",
                "Phase 3",
                "Phase 4"
            ]
            if let text = dropDown1.textField.text, !text.isEmpty {
                dropDownHandler(text: &subBasinView.textField, ddView: &subBasinView)
                centeredDropDown.show()
            }
            
        case 3:
            dropDownArray = [
                "Phase 1",
                "Phase 2",
                "Phase 3",
                "Phase 4"
            ]
            if let text = subBasinView.textField.text, !text.isEmpty {
                dropDownHandler(text: &districtDDView.textField, ddView: &districtDDView)
                centeredDropDown.show()
            }
            
        case 4:
            dropDownArray = [
                "Phase 1",
                "Phase 2",
                "Phase 3",
                "Phase 4"
            ]
            if let text = districtDDView.textField.text, !text.isEmpty {
                dropDownHandler(text: &blockDDView.textField, ddView: &blockDDView)
                centeredDropDown.show()
            }
            
        case 5:
            dropDownArray = [
                "Phase 1",
                "Phase 2",
                "Phase 3",
                "Phase 4"
            ]
            if let text = blockDDView.textField.text, !text.isEmpty {
                dropDownHandler(text: &villageDDView.textField, ddView: &villageDDView)
                centeredDropDown.show()
            }
            
        case 6:
            dropDownArray = [
                "Phase 1",
                "Phase 2",
                "Phase 3",
                "Phase 4"
            ]
            if let text = villageDDView.textField.text, !text.isEmpty {
                dropDownHandler(text: &componentDDView.textField, ddView: &componentDDView)
                centeredDropDown.show()
            }
            
        case 7:
            dropDownArray = [
                "Phase 1",
                "Phase 2",
                "Phase 3",
                "Phase 4"
            ]
           
            if let text = componentDDView.textField.text, !text.isEmpty {
                dropDownHandler(text: &subComponentDDView.textField, ddView: &subComponentDDView)
                centeredDropDown.show()
            }
            
        case 8:
            dropDownArray = [
                "Phase 1",
                "Phase 2",
                "Phase 3",
                "Phase 4"
            ]
            if let text = subComponentDDView.textField.text, !text.isEmpty {
                dropDownHandler(text: &stagesDDView.textField, ddView: &stagesDDView)
                centeredDropDown.show()
            }
            
        case 9:
            dropDownArray = [
                "Male",
                "Female",
                "Transgender"
            ]
            dropDownHandler(text: &genderDDView.textField, ddView: &genderDDView)
            centeredDropDown.show()
        case 10:
            dropDownArray = [
                "SC",
                "ST",
                "Others"
            ]
            dropDownHandler(text: &categoryDDView.textField, ddView: &categoryDDView)
            centeredDropDown.show()
        case 11:
            dropDownArray = [
                "Demo",
                "Sustainability",
                "Adoption"
            ]
            dropDownHandler(text: &interventionTypeDDView.textField, ddView: &interventionTypeDDView)
            centeredDropDown.show()
        default:
            return
        }
    }
}

extension DepartmentDetailsViewController: calendarDateSelectDelegate {
    func selectedDate(text: String, tag: Int) {
        calendarTextField.text = text
    }
}

//extension DepartmentDetailsViewController: UIViewControllerTransitioningDelegate {
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        return PopUpPresentationController(presentedViewController: presented, presenting: presenting)
//    }
//}


extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
