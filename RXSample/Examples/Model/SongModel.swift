//
//  SongModel.swift
//  RXSample
//
//  Created by liangze on 2019/9/6.
//  Copyright © 2019 liangze. All rights reserved.
//

import Foundation

struct SongModel: AutoMappable {
    init?(map: Map) { }
    
    struct Singer: AutoMappable {
        init?(map: Map) { }

        var name = ""
        var name_usual = ""
        var avatar = ""//图像
        var region = [String]()
        var genre = [String]()
    }
    
    
    var albumtitle = ""
    var url = ""
    var file_ext = "" //: "mp4",
    var title = "骊歌"
    var picture = ""// "https://img3.doubanio.com/view/site/large/public/ec4c80be09d5c12.jpg",
    var singers = [Singer]()
    var artist = "GALA"
    var is_royal = true
    
    
    var intType = 0
}



