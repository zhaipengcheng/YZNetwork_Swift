//
//  YZLoginModel.swift
//  YZNetwork_Swift
//
//  Created by 翟鹏程 on 2023/11/7.
//

import UIKit
import HandyJSON

class YZLoginModel: YZBaseModel {
    var userID: String!
    var token: String!
    var session: String!
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        
        mapper <<< self.userID <-- "user_id"
    }
}
