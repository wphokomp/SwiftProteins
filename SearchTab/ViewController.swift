//
//  ViewController.swift
//  SearchTab
//
//  Created by Linda MUCASSI on 2018/11/14.
//  Copyright © 2018 Linda MUCASSI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var ligandArr = [Ligand]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLigands()
    }
    
    private func setLigands() {
        ligandArr.append(Ligand(name: "XAN", image: "L0"))
        ligandArr.append(Ligand(name: "VU3", image: "L1"))
        ligandArr.append(Ligand(name: "YL3", image: "L2"))
        ligandArr.append(Ligand(name: "VU2", image: "L3"))
        ligandArr.append(Ligand(name: "ZYJ", image: "L4"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ligandArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = ligandArr[indexPath.row].name
        cell.imgView.image = UIImage(named: ligandArr[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
