//
//  Constants.swift
//  desafio-ios-fernando-cani
//
//  Created by Fernando Cani on 13/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import Foundation

let fake: Bool = false
enum EnumEndpoints {
    case characters
    case comics(String)
    
    func toString() -> String {
        switch self {
        case .characters: return "characters"
        case .comics(let id): return "characters/\(id)/comics"
        }
    }
}

enum EnumImageFolder: String {
    case avatar
    case cover
}

let public_key = "b38d826c83112788dd36c16977e133a2"
let private_key = "c53ce17af6ad9f0ca73ba470434f46e75b310011"
let base_url = "https://gateway.marvel.com:443/v1/public/"
var ts: String {
    get {
        return String(Int(NSDate().timeIntervalSince1970) * 1000)
    }
}
var hash: String {
    get {
        return (ts+private_key+public_key).md5
    }
}
var suffix: String {
    get {
        return "apikey=\(public_key)" + "&ts=\(ts)" + "&hash=\(hash)"
    }
}
