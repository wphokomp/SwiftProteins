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
            print("\(ligFile)")
        } catch let error as NSError {
            print("Failed to read file")
            print(error)
        }
//        print(fileContent)
        print("file ended")
    }
    
    private func setSearchBar() {
        searchBar.delegate = self
    }
    private func setLigands() {
        for i in 0..<ligFile.count {
            ligandArr.append(Ligand(name: ligFile[i], image: genRand()))
        }
        currentLigandArr = ligandArr

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
        guard !searchText.isEmpty else {
            currentLigandArr = ligandArr
            TableView.reloadData()
            return
        }
        currentLigandArr = ligandArr.filter({ ligand -> Bool in
            return ligand.name.lowercased().contains(searchText.lowercased())
        })
        TableView.reloadData()
    }

    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentLigandArr = ligandArr //get all ligands
        case 1:
            currentLigandArr = ligandArr
//            currentLigandArr = currentLigandArr.filter({ textLigand -> Bool in
//                //get ligands with just text
//                return
//            })
        case 2:
            currentLigandArr = ligandArr
//            currentLigandArr = currentLigandArr.filter({ numLigand -> Bool in
//                //get ligands with just number
//                return
//            })
        default:
            break
        }
        TableView.reloadData()
    }
}

class Ligand {
    let name : String
    let image : String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
