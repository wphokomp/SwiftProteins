//
//  ViewController.swift
//  SearchTab
//
//  Created by Linda MUCASSI on 2018/11/14.
//  Copyright © 2018 Linda MUCASSI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var ligandArr = [Ligand]()
    var currentLigandArr = [Ligand]()
    var ligFile = [String]()
    var imgFile = ["L0", "L1", "L2", "L3", "L4", "L5", "L6", "L7", "L8", "L9", "L10", "L11", "L12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLigandsFile()
        setLigands()
        setSearchBar()
    }
    
    private func genRand() -> String {
        let randomName: String = imgFile.randomElement()!
        return randomName
    }
    private func getLigandsFile() {
        //read from file
        let fileURL = Bundle.main.path(forResource: "ligands", ofType: "txt")
        var fileContent = ""
        do {
            fileContent = try String(contentsOfFile: fileURL!, encoding: String.Encoding.utf8)
            ligFile = fileContent.components(separatedBy: "\n") as [String]
        } catch let error as NSError {
            print("Failed to read file")
            print(error)
        }
    }
    
    private func setSearchBar() {
        searchBar.delegate = self
    }
    
    func containsOnlyLetters(input: String) -> Bool {
        for chr in input.characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    private func setLigands() {
        for i in 0..<ligFile.count {
            if let num = Int(ligFile[i]) {
                ligandArr.append(Ligand(name: ligFile[i], category: .allNum, image: genRand()))
            } else if containsOnlyLetters(input: ligFile[i]) {
                ligandArr.append(Ligand(name: ligFile[i], category: .allText, image: genRand()))
            } else {
                ligandArr.append(Ligand(name: ligFile[i], category: .all, image: genRand()))
            }
        }
        currentLigandArr = ligandArr
        print(ligandArr)
        print(ligFile)
        print(currentLigandArr)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentLigandArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = currentLigandArr[indexPath.row].name
        cell.imgView.image = UIImage(named: currentLigandArr[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    //search barr
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty else {
//            currentLigandArr = ligandArr
//            TableView.reloadData()
//            return
//        }
        currentLigandArr = ligandArr.filter({ ligand -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return ligand.name.lowercased().contains(searchText.lowercased())
            case 1:
                if searchText.isEmpty { return ligand.category == .allText }
                return ligand.name.lowercased().contains(searchText.lowercased()) &&
                ligand.category == .allText
            case 2:
                if searchText.isEmpty { return ligand.category == .allNum }
                return ligand.name.lowercased().contains(searchText.lowercased()) &&
                ligand.category == .allNum
            default:
                return false
            }
        })
        TableView.reloadData()
    }

    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentLigandArr = ligandArr //get all ligands
        case 1:
            currentLigandArr = currentLigandArr.filter({ ligand -> Bool in
                //get ligands with just text
                ligand.category == LigandType.allText
            })
        case 2:
            currentLigandArr = currentLigandArr.filter({ ligand -> Bool in
                //get ligands with just number
                ligand.category == LigandType.allNum
            })
        default:
            break
        }
        TableView.reloadData()
    }
}

class Ligand {
    let name : String
    let category : LigandType
    let image : String
    
    init(name: String, category: LigandType, image: String) {
        self.name = name
        self.category = category
        self.image = image
    }
}

enum LigandType: String {
    case allText = "allText"
    case allNum = "allNum"
    case all = "all"
}
