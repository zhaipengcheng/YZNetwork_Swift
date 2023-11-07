//
//  User.swift
//  YZNetwork_Swift
//
//  Created by 翟鹏程 on 2023/10/25.
//

import Foundation
import HandyJSON

class User : YZBaseModel {
    var id: String!
    var nickname: String!
    var phone: String!
    var avatar: String!
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<< self.nickname <-- "nick_name"
    }
}
