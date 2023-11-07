//
//  YZDetailResponse.swift
//  YZNetwork_Swift
//  详情类网络请求响应模型（根据自身项目）


import Foundation
import HandyJSON
/// 继承BaseResponse
/// 定义了一个泛型T
/// 泛型实现了HandyJSON协议
/// 因为我们希望用户传递的类要能解析为JSON

class YZDetailReponse<T: HandyJSON>: YZBaseResponse {
    var data: T?
    
    init(_ data: T) {
        self.data = data
    }
    
    required init() {
        super.init()
    }
}
