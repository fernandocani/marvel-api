//
//  SpecMainViewController.swift
//  desafio-ios-fernando-caniTests
//
//  Created by Fernando Cani on 10/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import XCTest
@testable import desafio_ios_fernando_cani

class SpecMainViewController: XCTestCase {
    
    let controller: MainViewController = MainViewController()
    let oneCharacter = MarvelCharacterDataContainer(offset: 0,
                                                    limit: 20,
                                                    total: 40,
                                                    count: 0,
                                                    results: [MarvelCharacters(id: 1,
                                                                               name: "name",
                                                                               description: "description",
                                                                               thumbnail: MarvelThumbnail(path: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp",
                                                                                                          extension: "png",
                                                                                                          image: UIImage()))])
    
    override func setUp() {
        self.controller.loadViewIfNeeded()
        //self.controller.loadCharacters(fake: true)
    }

    override func tearDown() {
        self.controller.characters.removeAll()
        self.controller.currentIndex = 0
        self.controller.numberOfItens = 0
    }
    
    func test1() {
        self.controller.setupView()
        XCTAssertTrue(self.controller.tableView.isHidden)
    }
    
    func test2() {
        self.controller.handleResults(characters: self.oneCharacter)
        XCTAssertEqual(self.controller.limit, 20)
        XCTAssertEqual(self.controller.currentIndex, 20)
        XCTAssertEqual(self.controller.numberOfItens, 40)
        XCTAssertEqual(self.controller.characters.count, 1)
    }
    
    func test3() {
        self.controller.loadCharacters(fake: true)
        XCTAssertEqual(self.controller.characters.count, 20)
    }
    
    func test4() {
        DispatchQueue.main.async {
            self.controller.handleResults(characters: self.oneCharacter)
            XCTAssertEqual(self.controller.characters.count, 1)
            XCTAssertTrue(self.controller.tableView.isHidden == true)
        }
    }
    
    func test5() {
        let asyncExpectation = expectation(description: "Async block executed")
        self.controller.handleResults(characters: self.oneCharacter)
        DispatchQueue.main.async {
            XCTAssertEqual(self.controller.characters.count, 1)
            XCTAssertTrue(self.controller.tableView.isHidden == false)
            asyncExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test6() {
        self.controller.handleResults(characters: self.oneCharacter)
        self.controller.tableView.reloadData()
        XCTAssertNotNil(self.controller.tableView.cellForRow(at: IndexPath(row: 0, section: 0)))
    }
    
    func test7() {
        self.controller.handleResults(characters: self.oneCharacter)
        self.controller.tableView.reloadData()
        XCTAssertTrue(self.controller.tableView.cellForRow(at: IndexPath(row: 0, section: 0))!.classForCoder == CharacterListTableViewCell.classForCoder())
    }

    func test8() {
        self.controller.handleResults(characters: self.oneCharacter)
        self.controller.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = self.controller.tableView.cellForRow(at: indexPath)!
        self.controller.tableView(self.controller.tableView, willDisplay: cell, forRowAt: indexPath)
    }

    func test9() {
        self.controller.handleResults(characters: self.oneCharacter)
        self.controller.tableView.reloadData()
        self.controller.tableView(self.controller.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    func test10() {
        self.controller.handleResults(characters: self.oneCharacter)
        self.controller.currentIndex = 1
        self.controller.numberOfItens = 2
        self.controller.loading = false
        self.controller.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = self.controller.tableView.cellForRow(at: indexPath)!
        self.controller.tableView(self.controller.tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
}
