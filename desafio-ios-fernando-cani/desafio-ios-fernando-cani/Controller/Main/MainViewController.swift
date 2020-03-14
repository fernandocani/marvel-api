//
//  MainViewController.swift
//  desafio-ios-fernando-cani
//
//  Created by Fernando Cani on 10/03/20.
//  Copyright © 2020 Fernando Cani. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    var characters: [MarvelCharacters] = Array()
    
    var currentIndex: Int = 0
    var numberOfItens: Int = 0
    var loading: Bool = false
    let limit: Int = 20
    var firstTime: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.accessibilityElements = [self.tableView!]
        self.title = "Marvel Heroes"
        self.navigationItem.titleView?.accessibilityLabel = "Marvel Heroes"
        self.setupView()
        self.loadCharacters(fake: fake)
    }
    
    func loadCharacters(fake: Bool) {
        self.progress.startAnimating()
        if fake {
            if let responseCharacters = Service.shared.loadJson(type: MarvelCharacter.self, filename: "responseCharacters"), var characters = responseCharacters.data {
                characters.total = 20
                self.handleResults(characters: characters)
            }
        } else {
            self.task()
        }
    }
    
    func setupView() {
        self.progress.isAccessibilityElement = false
        self.tableView.isHidden = true
        self.tableView.register(UINib(nibName: "CharacterListTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterListTableViewCell")
    }

    func task() {
        self.loading = true
        Service.shared.taskCharacter(offset: String(self.currentIndex), callbackSuccess: { (characters) in
            self.handleResults(characters: characters)
        }, callbackError: { (error) in
            print(error ?? "erro desconhecido")
            self.loading = false
        })
    }
    
    func handleResults(characters: MarvelCharacterDataContainer) {
        if let c = characters.results, let offset = characters.offset, let total = characters.total {
            self.characters.append(contentsOf: c)
            self.currentIndex = offset + self.limit
            self.numberOfItens = total
        }
        self.loading = false
        if self.firstTime {
            self.firstTime = false
            DispatchQueue.main.async {
                self.progress.stopAnimating()
            }
        }
        DispatchQueue.main.async {
            if self.characters.count > 0 {
                self.tableView.isHidden = false
                self.tableView.reloadData()
                for (index, char) in self.characters.enumerated() {
                    if let image = Service.shared.readImage(type: .avatar, withFileName: char.thumbnail.pathString()) {
                        self.characters[index].thumbnail.image.value = image
                    } else {
                        Service.shared.downloadAvatar(from: char.thumbnail.path, with: char.thumbnail.extension, callBack: { (image) in
                            self.characters[index].thumbnail.image.value = image
                        }, callBackError: {
                            self.characters[index].thumbnail.image.value = #imageLiteral(resourceName: "placeholder.png")
                        })
                    }
                }
            } else {
                self.tableView.isHidden = true
            }
        }
    }

}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterListTableViewCell", for: indexPath) as? CharacterListTableViewCell else { return UITableViewCell() }
        cell.setup(character: &self.characters[indexPath.row])
        return cell
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.currentIndex - 1 {
            if self.currentIndex < self.numberOfItens {
                if !self.loading {
                    self.task()
                    let lastSectionIndex = tableView.numberOfSections - 1
                    let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
                    if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
                        let spinner = UIActivityIndicatorView(style: .medium)
                        spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 70)
                        spinner.startAnimating()
                        tableView.tableFooterView = spinner
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(CharacterDetailViewController(character: self.characters[indexPath.row]), animated: true)
    }
    
}
