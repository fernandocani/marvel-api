//
//  SpecCharacterDetailViewController.swift
//  desafio-ios-fernando-caniTests
//
//  Created by Fernando Cani on 14/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import XCTest
@testable import desafio_ios_fernando_cani

class SpecCharacterDetailViewController: XCTestCase {

    let controller: CharacterDetailViewController = CharacterDetailViewController(character: MarvelCharacters(id: 1,
                                                                                                              name: "name",
                                                                                                              description: "description",
                                                                                                              thumbnail: MarvelThumbnail(path: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp",
                                                                                                                                         extension: "png",
                                                                                                                                         image: UIImage())))
    let oneCharacter = MarvelCharacters(id: 1,
                                        name: "name",
                                        description: "description",
                                        thumbnail: MarvelThumbnail(path: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp",
                                                                   extension: "png",
                                                                   image: UIImage()))
    
    override func setUp() {
        self.controller.loadViewIfNeeded()
    }

    override func tearDown() {
        self.controller.character = self.oneCharacter
    }
    
    func test1() {
        XCTAssertEqual(self.controller.title, self.controller.character.name)
    }
    
    func test2() {
        self.controller.character.name = nil
        self.controller.character.description = nil
        self.controller.setupView()
        XCTAssertTrue(self.controller.viewIcon.isHidden)
        XCTAssertTrue(self.controller.stackViewName.isHidden)
        XCTAssertTrue(self.controller.stackViewDescription.isHidden)
    }
    
    func test3() {
        self.controller.setupView()
        XCTAssertTrue(self.controller.viewIcon.isHidden)
        XCTAssertFalse(self.controller.stackViewName.isHidden)
        XCTAssertFalse(self.controller.stackViewDescription.isHidden)
    }
    
    func test4() {
        self.controller.lblDescription.numberOfLines = 0
        self.controller.btnDescription(self.controller.btnDescription)
        XCTAssertEqual(self.controller.lblDescription.numberOfLines, 3)
    }
    
    func test5() {
        self.controller.lblDescription.numberOfLines = 3
        self.controller.btnDescription(self.controller.btnDescription)
        XCTAssertEqual(self.controller.lblDescription.numberOfLines, 0)
    }

    
    
}
