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
    var cuurentLigandArr = [Ligand]()
    
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
        
        cuurentLigandArr = ligandArr

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cuurentLigandArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = cuurentLigandArr[indexPath.row].name
        cell.imgView.image = UIImage(named: cuurentLigandArr[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    //search barr
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cuurentLigandArr = ligandArr.filter({ ligand -> Bool in
            guard let text = searchBar.text else { return false }
            return ligand.name.contains(text)
        })
        TableView.reloadData()
    }

    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
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
