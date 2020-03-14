//
//  Service+Documents.swift
//  desafio-ios-fernando-cani
//
//  Created by Fernando Cani on 14/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import UIKit

extension Service {
    
    private func createFileDirectory(folder: String) {
        guard let documentDirectory = self.documentDirectory() else { return }
        let folder = documentDirectory.appendingPathComponent(folder)
        do {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        } catch { }
    }
    
    private func exists(folder: String) -> Bool {
        do {
            let subpaths = try FileManager.default.subpathsOfDirectory(atPath: self.documentDirectory().removeExtra())
            return subpaths.contains(folder)
        } catch {
            return false
        }
    }
    
    func documentDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func readImage(type: EnumImageFolder, withFileName fileName: String) -> UIImage? {
        guard let documentDirectory = self.documentDirectory() else { return nil }
        let fileURL = documentDirectory.appendingPathComponent(type.rawValue + "/" +  fileName.replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: ":", with: "_"))
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                return UIImage(data: data)
            } catch { }
        }
        return nil
    }
    
    func saveImage(type: EnumImageFolder, image: UIImage, withFileName fileName: String) {
        guard let documentDirectory = self.documentDirectory() else { return }
        if !self.exists(folder: type.rawValue) {
            self.createFileDirectory(folder: type.rawValue)
        }
        let fileURL = documentDirectory.appendingPathComponent(type.rawValue + "/" + fileName.replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: ":", with: "_"))
        if let data = image.pngData(), !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try data.write(to: fileURL)
            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    func clearDocumentDirectory() {
        let fileManager = FileManager.default
        let path = self.documentDirectory()!.path
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: path)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: path + "/" + filePath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
}
