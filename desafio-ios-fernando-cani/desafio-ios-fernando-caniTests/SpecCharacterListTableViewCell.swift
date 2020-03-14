//
//  SpecCharacterListTableViewCell.swift
//  desafio-ios-fernando-caniTests
//
//  Created by Fernando Cani on 14/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import XCTest
@testable import desafio_ios_fernando_cani

class SpecCharacterListTableViewCell: XCTestCase {

    let cell: CharacterListTableViewCell = Bundle(for: CharacterListTableViewCell.self).loadNibNamed("CharacterListTableViewCell", owner: nil)?.first as! CharacterListTableViewCell
    var oneCharacter = MarvelCharacters(id: 1,
                                        name: "name",
                                        description: "description",
                                        thumbnail: MarvelThumbnail(path: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp",
                                                                   extension: "png",
                                                                   image: UIImage()))
    
    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func test1() {
        self.cell.setup(character: &self.oneCharacter)
        XCTAssertNotNil(self.cell.lblTitle.text)
    }
    
    func test2() {
        self.cell.setup(character: &self.oneCharacter)
        XCTAssertEqual(self.cell.lblTitle.text!, self.oneCharacter.name)
    }
    
    func test3() {
        self.cell.prepareForReuse()
        XCTAssertNil(self.cell.imgIcon.image)
        XCTAssertNil(self.cell.lblTitle.text)
    }

}
