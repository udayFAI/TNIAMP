//
//  Login.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 11/01/24.
//

import UIKit

struct GlobalData {
    static var shared = GlobalData() // Singleton instance

    private var _phone: String = ""
    private var _deptID: Int = 0
    private var _phaseID: Int = 0
    private var  _subBasinID: Int = 0
    private var _districtID : Int = 0
    private var _blockID : Int = 0
    private var _villagedet: Int = 0
    private var _tnauLooup: Int = 0
    private var _subComponentID: Int = 0
    private var _stagesID : Int = 0
    
    var phone: String {
        get { return _phone }
        set { _phone = newValue }
    }

    var deptID: Int {
        get { return _deptID }
        set { _deptID = newValue }
    }
    
    var phaseID : Int {
        get { return _phaseID }
        set { _phaseID = newValue }
    }
    
    var subBasinID : Int {
        get { return _subBasinID }
        set { _subBasinID = newValue }
    }
    
    var districtID : Int {
        get { return _districtID }
        set { _districtID = newValue }
    }
    
    var blockId : Int {
        get { return _blockID }
        set { _blockID = newValue }
    }
    
    var villageId : Int {
        get { return _villagedet }
        set { _villagedet = newValue }
    }
    
    var tnauLookUp : Int {
        get { return _tnauLooup }
        set { _tnauLooup = newValue }
    }
    
    var subComponentId : Int {
        get { return _subComponentID }
        set { _subComponentID = newValue }
    }
    
    var stagesId : Int {
        get { return _stagesID }
        set { _stagesID = newValue }
    }
}

