//
//  DouBanApi.swift
//  RXSample
//
//  Created by liangze on 2019/9/6.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation

extension TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
}

enum FMApi: TargetType {
    case channels //https://www.douban.com/j/app/radio/channels
    case playlist //https://douban.fm/j/mine/playlist
    
    var baseURL: URL {
        switch self {
        case .channels:
            return URL(string: "https://www.douban.com")!
        case .playlist:
            return URL(string: "https://douban.fm")!
        }
    }
    
    var path: String {
        switch self {
        case .channels:
            return "j/app/radio/channels"
        case .playlist:
            return "j/mine/playlist"
        }
    }
    
    var method: Moya.Method {
         return .get
    }
    
   
    
    var task: Task {
        return .requestPlain
    }
}
