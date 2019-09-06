// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// MARK: Channel Mappable
extension Channel {

    mutating func mapping(map: Map) {
        name_en <- map["name_en"]
        seq_id <- map["seq_id"]
        abbr_en <- map["abbr_en"]
        name <- map["name"]
        channel_id <- map["channel_id"]
    }
}

