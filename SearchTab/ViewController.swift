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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLigands()
        setSearchBar()
    }
    
    private func setSearchBar() {
        searchBar.delegate = self
    }
    private func setLigands() {
        ligandArr.append(Ligand(name: "XAN", image: "L0"))
        ligandArr.append(Ligand(name: "VU3", image: "L1"))
        ligandArr.append(Ligand(name: "YL3", image: "L2"))
        ligandArr.append(Ligand(name: "VU2", image: "L3"))
        ligandArr.append(Ligand(name: "ZYJ", image: "L4"))
        
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
