//
//  Service.swift
//  desafio-ios-fernando-cani
//
//  Created by Fernando Cani on 10/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import UIKit

class Service {
 
    static let shared = Service()
    
    func taskCharacter(orderBy: String? = "name", limit: String? = "20", offset: String? = "0", callbackSuccess: @escaping ((MarvelCharacterDataContainer) -> Void), callbackError: @escaping ((Error?) -> Void)) {
        var url_string: String = base_url + EnumEndpoints.characters.toString()
        url_string += "?"
        if let orderBy = orderBy {
            if url_string.last != "?" {
                url_string += "&"
            }
            url_string += "orderBy=" + orderBy
        }
        if let limit = limit {
            if url_string.last != "?" {
                url_string += "&"
            }
            url_string += "limit=" + limit
        }
        if let offset = offset {
            if url_string.last != "?" {
                url_string += "&"
            }
            url_string += "offset=" + offset
        }
        if url_string.last != "?" {
            url_string += "&"
        }
        url_string += suffix
        self.task(type: MarvelCharacter.self, url_string: url_string, callbackSuccess: { (dataWrapper) in
            if let dataContainer = dataWrapper.data {
                callbackSuccess(dataContainer)
            } else {
                callbackError(nil)
            }
        }, callbackError: { (error) in
            callbackError(error)
        })
    }
    
    func taskComics(id: String, callbackSuccess: @escaping ((MarvelComicsData) -> Void), callbackError: @escaping ((Error?) -> Void)) {
        var url_string: String = base_url + EnumEndpoints.comics(id).toString()
        url_string += "?"
        if url_string.last != "?" {
            url_string += "&"
        }
        url_string += suffix
        self.task(type: MarvelComics.self, url_string: url_string, callbackSuccess: { (dataWrapper) in
            if let dataContainer = dataWrapper.data {
                callbackSuccess(dataContainer)
            } else {
                callbackError(nil)
            }
        }, callbackError: { (error) in
            callbackError(error)
        })
    }
    
    fileprivate func task<T: Codable>(type: T.Type, url_string: String, callbackSuccess: @escaping ((T) -> Void), callbackError: @escaping ((Error?) -> Void)) {
        guard let url: URL = URL(string: url_string) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { callbackError(nil); return }
            do {
                let dataWrapper: T = try JSONDecoder().decode(T.self, from: data)
                callbackSuccess(dataWrapper)
            } catch {
                callbackError(error)
            }
        }
        task.resume()
    }
    
    func loadJson<T: Codable>(type: T.Type, filename: String) -> T? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
}
