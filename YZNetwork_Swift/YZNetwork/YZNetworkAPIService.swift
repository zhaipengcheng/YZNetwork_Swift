//
//  NetworkAPIService.swift
//  YZNetwork_Swift
//  网络API

import Foundation
import Moya

enum YZNetworkAPIService {
    // MARK: 此处填写API,例子
    case login(data: User)
    
    case postAPI1
    case postAPI2
    case postAPI3
    case postAPI4

    case patchAPI
    
    case deleteAPI
    
    case getAPI
}



// MARK: - 实现TargetType协议
extension YZNetworkAPIService: TargetType {
    /// 返回项目网络请求网址
    var baseURL: URL {
        return URL(string: YZNetworkConfig.BASE_URL)!
    }
    /// 返回网络请求的路径
    var path: String {
        switch self {
        // MARK: 添加项目网络请求地址
        case .login:
            return "v1/login"
            
        case .postAPI1:
            return "v2/postAPI1"
            
        case .postAPI3:
            return "v3/postApi3"
            
        case .getAPI:
            return "v11/getApi111"
            
        default:
            fatalError("DefaultService path is null")
        }
    }
    /// 请求方式
    var method: Moya.Method {
        switch self {
        case .login, .postAPI1, .postAPI2, .postAPI3:
            return .post
            
        case .patchAPI:
            return .patch
            
        case .deleteAPI:
            return .delete
            
        default:
            return .get
        }
    }

    /// 请求的参数
    var task: Task {
        switch self {
        case .login(let data):
            return .requestData(data.toJSONString()!.data(using: .utf8)!)
        default:
            //不传递任何参数
            return .requestPlain
        }
    }
    
    //MARK: 请求头（根据项目添加）
    var headers: [String : String]? {
        var headers:Dictionary<String,String> = [:]
        //内容的类型
        headers["Content-Type"]="application/json"
        return headers
    }

}
