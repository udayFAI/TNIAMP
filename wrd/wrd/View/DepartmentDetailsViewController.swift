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
    
    var viewModel = DashboardViewModel.shared
    var phaseDropDownIndex = 0
    var deptSelectionID: Int = 0
    
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
       dropDowns.forEach { $0.direction = .any }
        
        landAreaTextField.delegate = self
        mobileTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch deptSelectionID  { // GlobalData.shared.deptID {
        case 1:
            DashboardViewModel.shared.tnauLookUP = viewModel.loadJsonFile_TnauLookup(fileName: "TNAULookUp")
        case 2:
            DashboardViewModel.shared.tnauLookUP = viewModel.loadJsonFile_TnauLookup(fileName: "AgricultureLookUp")
            calendarTextField.isHidden = true
        case 3:
            DashboardViewModel.shared.tnauLookUP = viewModel.loadJsonFile_TnauLookup(fileName: "HorticultureLookUp")
        case 4:
            DashboardViewModel.shared.tnauLookUP = viewModel.loadJsonFile_TnauLookup(fileName: "AEDLookUp")
        case 5:
            DashboardViewModel.shared.tnauLookUP = viewModel.loadJsonFile_TnauLookup(fileName: "AnimalLookUp")
        case 6:
            DashboardViewModel.shared.tnauLookUP = viewModel.loadJsonFile_TnauLookup(fileName: "WRDLookUp")
        case 7:
            DashboardViewModel.shared.tnauLookUP = viewModel.loadJsonFile_TnauLookup(fileName: "MarketingLookUp")
        case 8:
            DashboardViewModel.shared.tnauLookUP = viewModel.loadJsonFile_TnauLookup(fileName: "FisheryLookUp")
        default:
            return
        }
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
            PrintLog.info("\(index) ------------ \(item)")
            dropDownDataSelection_basedOnIndex(index: capturedText.tag, value: item, selected_Index: index)
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
    
    func dropDownDataSelection_basedOnIndex(index: Int, value: String, selected_Index: Int) {
        switch index {
        case 1:
            if let selectedIndex = dropDownArray.firstIndex(of: value) {
                GlobalData.shared.phaseID = selectedIndex + 1
            } else {
               // TODO: - Index out of range.
            }
        case 2:
            GlobalData.shared.subBasinID = DashboardViewModel.shared.sub_Basin?.first(where: {$0.name == value})?.id ?? 0
        case 3:
            if let index = DashboardViewModel.shared.district?.filter({$0.subBasinID == GlobalData.shared.subBasinID}) {
                GlobalData.shared.districtID = index[selected_Index].id ?? 0
            }
          //  phaseDropDownIndex =  DashboardViewModel.shared.district?.first(where: {$0.name == value})?.subBasinID ?? 0
        case 4:
            if let index = DashboardViewModel.shared.block?.filter({$0.districtID ?? 0 == GlobalData.shared.districtID}) {
                GlobalData.shared.blockId = Int(index[selected_Index].id ?? 0)
            }
           // phaseDropDownIndex = Int(DashboardViewModel.shared.block?.first(where: {$0.name == value})?.districtID ?? 0)
        case 5:
            if let index = DashboardViewModel.shared.village?.filter({$0.blockID ?? 0 == GlobalData.shared.blockId}) {
                GlobalData.shared.villageId = Int(index[selected_Index].id ?? 0)
            }
        case 6:
            if let index = DashboardViewModel.shared.tnauLookUP?.filter({$0.parentID ?? 0 == 0}) {
                GlobalData.shared.tnauLookUp = Int(index[selected_Index].id ?? 0)
            }
        case 7:
            if let index = DashboardViewModel.shared.tnauLookUP?.filter({$0.parentID ?? 0 == 1}) {
                GlobalData.shared.subComponentId = Int(index[selected_Index].id ?? 0)
            }
        case 8:
            if let index = DashboardViewModel.shared.tnauLookUP?.filter({$0.parentID ?? 0 == 0}) {
                GlobalData.shared.tnauLookUp = Int(index[selected_Index].id ?? 0)
            }
           // phaseDropDownIndex = Int(DashboardViewModel.shared.village?.first(where: {$0.name == value})?.blockID ?? 0)
        default:
            return
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
    }
    
    func getCurrentLocation() {
        LocationManager.shared.getLocation { [self] (location:CLLocation?, error:NSError?) in
            if let error = error {
                print(error.localizedDescription)
                AlertHelper.showAlertWithYesNo(title: StaticString.alertTitle, message: "Need to enable location permission.", viewController: self) { [self] in
                    openLocationSettings()
                } noAction: {
                    
                }
                return
            }
            guard let location = location else {
                return
            }
            print("Latitude: \(location.coordinate.latitude) Longitude: \(location.coordinate.longitude)")
        }
    }
    
    func getCurrentLocation(completion: @escaping (Bool) -> Void) {
        LocationManager.shared.getLocation { [self] (location: CLLocation?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else if let location = location {
                // Access location details here if needed
                // ...
                completion(true)
            } else {
                print("Location not available")
                completion(false)
            }
        }
    }

    
    func openLocationSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, completionHandler: { _ in
                // Handle any completion actions if needed
            })
        } else {
            print("Couldn't open Settings app")
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
        }
        getCurrentLocation { success in
            if success {
                print("Location retrieved successfully")
               // TODO: - Register Netowrk
            } else {
                AlertHelper.showAlertWithYesNo(title: StaticString.alertTitle, message: "Need to enable location permission.", viewController: self) { [self] in
                    openLocationSettings()
                } noAction: {
                    
                }
            }
        }
//        else {
//            AlertHelper.showAlert(title: "TNIAMP", message: "Please enter all the fields", viewController: self)
//        }
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
            dropDownArray = DashboardViewModel.shared.sub_Basin?.filter({$0.phase1 == GlobalData.shared.phaseID}).compactMap({$0.name}) ?? []
            if let text = dropDown1.textField.text, !text.isEmpty {
                dropDownHandler(text: &subBasinView.textField, ddView: &subBasinView)
                centeredDropDown.show()
            }
        case 3:
            dropDownArray = DashboardViewModel.shared.district?.filter({$0.subBasinID == GlobalData.shared.subBasinID}).compactMap({$0.name}) ?? []
            if let text = subBasinView.textField.text, !text.isEmpty {
                dropDownHandler(text: &districtDDView.textField, ddView: &districtDDView)
                centeredDropDown.show()
            }
            
        case 4:
            dropDownArray = DashboardViewModel.shared.block?.filter({$0.districtID ?? 0 == GlobalData.shared.districtID}).compactMap({$0.name}) ?? []
            if let text = districtDDView.textField.text, !text.isEmpty {
                dropDownHandler(text: &blockDDView.textField, ddView: &blockDDView)
                centeredDropDown.show()
            }
            
        case 5:
            dropDownArray = DashboardViewModel.shared.village?.filter({$0.blockID == GlobalData.shared.blockId}).compactMap({$0.name}) ?? []
            if let text = blockDDView.textField.text, !text.isEmpty {
                dropDownHandler(text: &villageDDView.textField, ddView: &villageDDView)
                centeredDropDown.show()
            }
            
        case 6:
            dropDownArray = DashboardViewModel.shared.tnauLookUP?.filter({$0.parentID == 0}).compactMap({$0.name}) ?? []
            if let text = villageDDView.textField.text, !text.isEmpty {
                dropDownHandler(text: &componentDDView.textField, ddView: &componentDDView)
                centeredDropDown.show()
            }
            
        case 7:
            dropDownArray = DashboardViewModel.shared.tnauLookUP?.filter({$0.parentID == 1}).compactMap({$0.name}) ?? []
           
            if let text = componentDDView.textField.text, !text.isEmpty {
                dropDownHandler(text: &subComponentDDView.textField, ddView: &subComponentDDView)
                centeredDropDown.show()
            }
            
        case 8:
            dropDownArray = DashboardViewModel.shared.tnauLookUP?.filter({$0.parentID == 10}).compactMap({$0.name}) ?? []
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

extension DepartmentDetailsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == landAreaTextField {
            guard let area = textField.text, Double(area) ?? 0 <= 2.0 else {
                AlertHelper.showAlert(title: StaticString.alertTitle, message: "Area of Intervention (ha) should not greater than 2", viewController: self)
                return }
        } else if textField == mobileTextField {
            if let text = mobileTextField.text, viewModel.validate.numberValidation(text: text), viewModel.validate.mobileNumberCount(text: text), viewModel.validate.isValidMobileNumber(text: text) {
                viewModel.mobileStatus = true
                PrintLog.success("Success")
            } else if let age = mobileTextField.text, age.count <= 0 {
                viewModel.mobileStatus = false
                PrintLog.error("Failure")
            } else {
                viewModel.mobileStatus = false
                PrintLog.error("Failure")
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileTextField {
            let currentText = textField.text?.trimmed() ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.isEmpty {
                PrintLog.error("Failure")
            }
            return viewModel.textFieldCharactersValidate(text: newText)
        }
        return true
    }
}
