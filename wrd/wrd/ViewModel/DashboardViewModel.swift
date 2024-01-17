//
//  DashboardViewModel.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 09/01/24.
//

import UIKit

@objc protocol dropDownResponseDelegate: AnyObject {
    @objc optional func dropDownData()
}

class DashboardViewModel: NSObject {
     var texts = ["No of data submit: 64", "No of offline Data: 0"]
    var departmentNames = ["TNAU", "Agriculture", "Horticulture", "AED", "Animal Husbandary", "WRD", "Marketing", "Fisheries"]
    var departmentLogos = ["tnau1", "agriculture", "horticulture", "aed", "animal", "wrd", "market", "fishery"]
    
    static let shared = DashboardViewModel()
    
    var validate: Validate =  Validate()
    let group = DispatchGroup()
    var sub_Basin: [SubBasin]?
    var district: [District]?
    var block: [Block_]?
    var village: [Village]?
    var tnauLookUP : [TNAULookUp]?
    
    var isWaiting = false
    weak var delegate: dropDownResponseDelegate?
    var mobileStatus = false
    
    func textFieldCharactersValidate(text: String) -> Bool {
        return validate.isDigitsAcceptDeleteBackSpace(text: text, maxLength: 10)
    }
    
    func loadJsonFile_SubBasin(fileName: String) -> [SubBasin]? {
        group.enter()
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let subBasin = try? decoder.decode([SubBasin].self, from: data)
       else {
            return nil
       }
        group.leave()
       return subBasin
    }
    
    func loadJsonFile_District(fileName: String) -> [District]? {
        group.enter()
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let subBasin = try? decoder.decode([District].self, from: data)
       else {
            return nil
       }
        group.leave()
       return subBasin
    }
    
    func loadJsonFile_Block(fileName: String) -> [Block_]? {
        group.enter()
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let subBasin = try? decoder.decode([Block_].self, from: data)
       else {
            return nil
       }
        group.leave()
       return subBasin
    }
    
    func loadJsonFile_Village(fileName: String) -> [Village]? {
        group.enter()
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let subBasin = try? decoder.decode([Village].self, from: data)
       else {
            return nil
       }
        group.leave()
       return subBasin
    }
    
    func loadJsonFile_TnauLookup(fileName: String) -> [TNAULookUp]? {
        group.enter()
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let subBasin = try? decoder.decode([TNAULookUp].self, from: data)
       else {
            return nil
       }
        group.leave()
       return subBasin
    }
    
    func loadJsonFile_AgricultureLookUp(fileName: String) -> [TNAULookUp]? {
        group.enter()
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let subBasin = try? decoder.decode([TNAULookUp].self, from: data)
       else {
            return nil
       }
        group.leave()
       return subBasin
    }
    
    func loadJsonFile_HorticultureLookUp(fileName: String) -> [TNAULookUp]? {
        group.enter()
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let subBasin = try? decoder.decode([TNAULookUp].self, from: data)
       else {
            return nil
       }
        group.leave()
       return subBasin
    }
    
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func userLooUp(_ param: [String:String]) {
        group.enter()
        APIManager.shared.requestLookUpSubBasin(tag: 0, parameters: param, responseObjectType: [SubBasin].self) { [self] response in
            group.leave()
          //  debugPrint("Sub Basin Response  ----------", response)
        } failure: { [self] error in
            debugPrint("Sub Basin Failure ----------", error)
            group.leave()
        }
    }
    
    func userLooUp_district(_ param: [String:String]) {
        group.enter()
        APIManager.shared.requestLookUpDistrict(tag: 1, parameters: param, responseObjectType: [District].self) { [self] response in
            group.leave()
          //  debugPrint("District Response ----------", response)
        } failure: { [self] error in
            debugPrint("District Failure ----------", error)
            group.leave()
        }
    }
    
    func userLooUp_block(_ param: [String:String]) {
        group.enter()
        APIManager.shared.requestLookUpBlock(parameters: param, responseObjectType: [Block_].self, success: {  [self] response in
            group.leave()
         //   debugPrint("Block Response ----------", response)
        }, failure: { [self] error in
            debugPrint("Block Failure ----------", error)
            group.leave()
        })
    }
    
    func userLooUp_village(_ param: [String:String]) {
        group.enter()
        APIManager.shared.requestLookUpVillage(parameters: param, responseObjectType: [Village].self, success: {  [self] response in
            group.leave()
//            debugPrint("Village Response ----------", response)
        }, failure: { [self] error in
            debugPrint("Village Failure ----------", error)
            group.leave()
        })
    }
    
    func multipleAPICallHandler() {
        self.isWaiting = true
        DashboardViewModel.shared.sub_Basin = loadJsonFile_SubBasin(fileName: "SubBasin")
        DashboardViewModel.shared.district = loadJsonFile_District(fileName: "district")
        DashboardViewModel.shared.block = loadJsonFile_Block(fileName: "block")
        DashboardViewModel.shared.village = loadJsonFile_Village(fileName: "village_det")
//        DashboardViewModel.shared.tnauLookUP = loadJsonFile_TnauLookup(fileName: "TNAULookUp")
        
//        userLooUp(["type":"sub_basin"])
//        userLooUp_district(["type": "district"])
//        userLooUp_block(["type":"block"])
//        userLooUp_village(["type":"village_det"])
        group.notify(queue: .main, execute: { [self] in
            delegate?.dropDownData?()
            self.isWaiting = false
        })
    }
}
