//
//  MarvelComics.swift
//  desafio-ios-fernando-cani
//
//  Created by Fernando Cani on 11/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import UIKit
import Foundation

// MARK: - MarvelComicsComics
struct MarvelComics: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: MarvelComicsData?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case attributionHTML = "attributionHTML"
        case etag = "etag"
        case data = "data"
    }
}

// MARK: - MarvelComicsData
struct MarvelComicsData: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [MarvelComicsResult]?

    enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }
}

// MARK: - MarvelComicsResult
struct MarvelComicsResult: Codable {
    var id: Int?
    var digitalID: Int?
    var title: String?
    var issueNumber: Int?
    var variantDescription: String?
    var resultDescription: String?
    var modified: String?
    var isbn: String?
    var upc: String?
    var diamondCode: String?
    var ean: String?
    var issn: String?
    var format: String?
    var pageCount: Int?
    var textObjects: [MarvelComicsTextObject]?
    var resourceURI: String?
    var urls: [MarvelComicsURL]?
    var series: MarvelComicsSeries?
    var variants: [MarvelComicsSeries]?
    var collections: [MarvelComicsSeries]?
    var collectedIssues: [MarvelComicsSeries]?
    var dates: [MarvelComicsDate]?
    var prices: [MarvelComicsPrice]?
    var thumbnail: MarvelComicsThumbnail
    var images: [MarvelComicsThumbnail]?
    var creators: MarvelComicsCreators?
    var characters: MarvelComicsCharacters?
    var stories: MarvelComicsStories?
    var events: MarvelComicsCharacters?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case digitalID = "digitalId"
        case title = "title"
        case issueNumber = "issueNumber"
        case variantDescription = "variantDescription"
        case resultDescription = "description"
        case modified = "modified"
        case isbn = "isbn"
        case upc = "upc"
        case diamondCode = "diamondCode"
        case ean = "ean"
        case issn = "issn"
        case format = "format"
        case pageCount = "pageCount"
        case textObjects = "textObjects"
        case resourceURI = "resourceURI"
        case urls = "urls"
        case series = "series"
        case variants = "variants"
        case collections = "collections"
        case collectedIssues = "collectedIssues"
        case dates = "dates"
        case prices = "prices"
        case thumbnail = "thumbnail"
        case images = "images"
        case creators = "creators"
        case characters = "characters"
        case stories = "stories"
        case events = "events"
    }
}

// MARK: - MarvelComicsCharacters
struct MarvelComicsCharacters: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [MarvelComicsSeries]?
    var returned: Int?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

// MARK: - MarvelComicsSeries
struct MarvelComicsSeries: Codable {
    var resourceURI: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
    }
}

// MARK: - MarvelComicsCreators
struct MarvelComicsCreators: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [MarvelComicsCreatorsItem]?
    var returned: Int?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

// MARK: - MarvelComicsCreatorsItem
struct MarvelComicsCreatorsItem: Codable {
    var resourceURI: String?
    var name: String?
    var role: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
        case role = "role"
    }
}

// MARK: - MarvelComicsDate
struct MarvelComicsDate: Codable {
    var type: String?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case date = "date"
    }
}

// MARK: - MarvelComicsThumbnail
struct MarvelComicsThumbnail: Codable {
    var path: String?
    var `extension`: String?
    var image: Observable<UIImage> = Observable(UIImage())

    enum CodingKeys: String, CodingKey {
        case path = "path"
        case `extension` = "extension"
    }
    
    init(image: UIImage) {
        self.image = Observable(image)
    }
    
    func pathString() -> String {
        guard let path = self.path, let ext = self.extension else { return String() }
        return "\(path).\(ext)"
    }
    
}

// MARK: - MarvelComicsPrice
struct MarvelComicsPrice: Codable {
    var type: String?
    var price: Double?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case price = "price"
    }
}

// MARK: - MarvelComicsStories
struct MarvelComicsStories: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [MarvelComicsStoriesItem]?
    var returned: Int?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

// MARK: - MarvelComicsStoriesItem
struct MarvelComicsStoriesItem: Codable {
    var resourceURI: String?
    var name: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
        case type = "type"
    }
}

// MARK: - MarvelComicsTextObject
struct MarvelComicsTextObject: Codable {
    var type: String?
    var language: String?
    var text: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case language = "language"
        case text = "text"
    }
}

// MARK: - MarvelComicsURL
struct MarvelComicsURL: Codable {
    var type: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }
}
