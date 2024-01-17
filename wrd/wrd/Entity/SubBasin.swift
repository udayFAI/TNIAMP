//
//  SubBasin.swift
//  wrd
//
//  Created by Kosuru Uday Saikumar on 12/01/24.
//

import UIKit

struct SubBasin: Codable {
    var id: Int?
    var name: String?
    var revisionNo, phase1, phase: Int?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "NAME"
        case revisionNo = "REVISION_NO"
        case phase1 = "PHASE1"
        case phase
    }
}

struct District: Codable {
    var id: Int?
    var name: String?
    var subBasinID, revisionNo: Int?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "NAME"
        case subBasinID = "SUB_BASIN_ID"
        case revisionNo = "REVISION_NO"
    }
}

struct Block_: Codable {
    var id: Int?
    var name: String?
    var districtID: UInt64?
    var revisionNo: UInt64?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "NAME"
        case districtID = "DISTRICT_ID"
        case revisionNo = "REVISION_NO"
    }
}

struct Village: Codable {
    var id: Int?
    var name: String?
    var blockID: Int?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "NAME"
        case blockID = "BLOCK_ID"
    }
}

struct TNAULookUp: Codable {
    var id: Int?
    var name: String?
    var parentID: Int?
    var revisionNo: Int?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case parentID = "PARENT_ID"
        case revisionNo = "revision_no"
    }
}
