//
//  Model.swift
//  desafio-ios-fernando-cani
//
//  Created by Fernando Cani on 10/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import UIKit
import Foundation

// MARK: - MarvelCharacter
struct MarvelCharacter: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: MarvelCharacterDataContainer?

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

// MARK: - MarvelCharacterDataContainer
struct MarvelCharacterDataContainer: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [MarvelCharacters]?

    enum CodingKeys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }
}

// MARK: - MarvelCharacters
struct MarvelCharacters: Codable {
    var id: Int?
    var name: String?
    var `description`: String?
    var modified: String?
    var thumbnail: MarvelThumbnail
    var resourceURI: String?
    var comics: MarvelCharacterComics?
    var series: MarvelCharacterSeries?
    var stories: MarvelCharacterStories?
    var events: MarvelCharacterEvents?
    var urls: [MarvelURL]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case `description` = "description"
        case modified = "modified"
        case thumbnail = "thumbnail"
        case resourceURI = "resourceURI"
        case comics = "comics"
        case series = "series"
        case stories = "stories"
        case events = "events"
        case urls = "urls"
    }
    
    init(id: Int? = nil,
         name: String? = nil,
         description: String? = nil,
         modified: String? = nil,
         thumbnail: MarvelThumbnail,
         resourceURI: String? = nil,
         comics: MarvelCharacterComics? = nil,
         series: MarvelCharacterSeries? = nil,
         stories: MarvelCharacterStories? = nil,
         events: MarvelCharacterEvents? = nil,
         urls: [MarvelURL]? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        self.urls = urls
    }
    
}

// MARK: - MarvelCharacterComics
struct MarvelCharacterComics: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [MarvelComicsItem]?
    var returned: Int?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

// MARK: - MarvelComicsItem
struct MarvelComicsItem: Codable {
    var resourceURI: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
    }
}

// MARK: - MarvelCharacterSeries
struct MarvelCharacterSeries: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [MarvelSeriesItem]?
    var returned: Int?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

// MARK: - MarvelSeriesItem
struct MarvelSeriesItem: Codable {
    var resourceURI: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
    }
}

// MARK: - MarvelCharacterStories
struct MarvelCharacterStories: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [MarvelStoriesItem]?
    var returned: Int?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

// MARK: - MarvelStoriesItem
struct MarvelStoriesItem: Codable {
    var resourceURI: String?
    var name: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
        case type = "type"
    }
}

// MARK: - MarvelCharacterEvents
struct MarvelCharacterEvents: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [MarvelEventsItem]?
    var returned: Int?

    enum CodingKeys: String, CodingKey {
        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }
}

// MARK: - MarvelEventsItem
struct MarvelEventsItem: Codable {
    var resourceURI: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case resourceURI = "resourceURI"
        case name = "name"
    }
}

// MARK: - MarvelThumbnail
struct MarvelThumbnail: Codable {
    var path: String?
    var `extension`: String?
    var image: Observable<UIImage> = Observable(UIImage())

    enum CodingKeys: String, CodingKey {
        case path = "path"
        case `extension` = "extension"
    }
    
    init(path: String? = nil,
         extension: String? = nil,
         image: UIImage) {
        self.path = path
        self.extension = `extension`
        self.image = Observable(image)
    }
    
    init(image: UIImage) {
        self.image = Observable(image)
    }
    
    func pathString() -> String {
        guard let path = self.path, let ext = self.extension else { return String() }
        return "\(path).\(ext)"
    }
    
}

// MARK: - MarvelURL
struct MarvelURL: Codable {
    var type: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }
}

struct Observable<T> {
    
    typealias Observer = String

    private var handlers: [Observer: (T) -> Void] = [:]

    var value: T {
        didSet {
            handlers.forEach { $0.value(value) }
        }
    }

    init(_ value: T) {
        self.value = value
    }

    @discardableResult
    mutating func observeNext(_ handler: @escaping (T) -> Void) -> Observer {
        let key = UUID().uuidString as Observer
        handlers[key] = handler
        return key
    }

    mutating func remove(_ key: Observer) {
        handlers.removeValue(forKey: key)
    }
    
}
