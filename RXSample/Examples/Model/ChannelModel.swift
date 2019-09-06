//
//  ChannelModel.swift
//  RXSample
//
//  Created by liangze on 2019/9/6.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation


struct Channel: AutoMappable {
    var name_en = ""
    var seq_id: Int?
    var abbr_en = ""
    var name = ""
    var channel_id = ""
    
    init?(map: Map) {
        
    }
}
