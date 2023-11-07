//
//  YZListResponse.swift
//  YZNetwork_Swift
//  列表类网络请求响应模型（根据自身项目）

import Foundation
import HandyJSON

class YZListResponse<T: HandyJSON>: YZBaseResponse {
    /// 分页元数据
    var data: YZPageMeta<T>!
}
