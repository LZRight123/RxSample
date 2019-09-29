// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
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
// MARK: SongModel Mappable
extension SongModel {

    mutating func mapping(map: Map) {
        albumtitle <- map["albumtitle"]
        url <- map["url"]
        file_ext <- map["file_ext"]
        title <- map["title"]
        picture <- map["picture"]
        singers <- map["singers"]
        artist <- map["artist"]
        is_royal <- map["is_royal"]
        intType <- map["intType"]
    }
}
// MARK: SongModel.Singer Mappable
extension SongModel.Singer {

    mutating func mapping(map: Map) {
        name <- map["name"]
        name_usual <- map["name_usual"]
        avatar <- map["avatar"]
        region <- map["region"]
        genre <- map["genre"]
    }
}
// MARK: TestModel Mappable
extension TestModel {

    mutating func mapping(map: Map) {
        stringType <- map["stringType"]
        doubleType <- map["doubleType"]
        intType <- map["intType"]
        boolType <- map["boolType"]
    }
}

