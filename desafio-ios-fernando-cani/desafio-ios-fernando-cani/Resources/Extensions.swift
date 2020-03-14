//
//  Extensions.swift
//  desafio-ios-fernando-cani
//
//  Created by Fernando Cani on 13/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import UIKit
import CommonCrypto

extension String {
    
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            //CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }

}

extension UITableView {
    
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() }) { _ in completion() }
    }

}

extension Optional where Wrapped == URL {
    
    func removeExtra() -> String {
        guard let url = self else { return String() }
        return url.absoluteString.replacingOccurrences(of: "file://", with: "")
    }
    
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 6
        self.clipsToBounds = false
    }
    
}
