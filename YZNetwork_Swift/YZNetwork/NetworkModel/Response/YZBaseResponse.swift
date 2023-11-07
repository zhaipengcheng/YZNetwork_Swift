//
//  YZBaseResponse.swift
//  YZNetwork_Swift
//  通用网络请求响应模型(根据自身项目更改)
import Foundation

class YZBaseResponse: YZBaseModel {
    // 状态码
    var status: Int = 0
    // 网络请求错误信息，不一定有
    var message: String?
}
