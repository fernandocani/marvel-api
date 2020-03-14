//
//  Service+Image.swift
//  desafio-ios-fernando-cani
//
//  Created by Fernando Cani on 14/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import UIKit

extension Service {
    
    func downloadAvatar(from link: String?, with ext: String?, callBack: @escaping ((UIImage) -> Void), callBackError: @escaping (() -> Void)) {
        self.downloadImage(type: .avatar, from: link, with: ext, callBack: callBack, callBackError: callBackError)
    }
    
    func downloadCover(from link: String?, with ext: String?, callBack: @escaping ((UIImage) -> Void), callBackError: @escaping (() -> Void)) {
        self.downloadImage(type: .cover, from: link, with: ext, callBack: callBack, callBackError: callBackError)
    }
    
    private func downloadImage(type: EnumImageFolder, from link: String?, with ext: String?, callBack: @escaping ((UIImage) -> Void), callBackError: @escaping (() -> Void)) {
        guard let l = link else { return }
        guard let e = ext else { return }
        let string = l + "." + e
        guard let url = URL(string: string) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType,
                mimeType.hasPrefix("image"),
                let data = data,
                error == nil,
                let image = UIImage(data: data) {
                Service.shared.saveImage(type: type, image: image, withFileName: url.absoluteString)
                callBack(image)
            } else {
                callBackError()
            }
        }.resume()
    }
    
}
