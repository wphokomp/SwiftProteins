//
//  ViewController.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/27.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var ligandList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedLigand = 0
    var ligandArr = [Ligand]()
    var currentLigandArr = [Ligand]()
    var ligFile = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setSearchBar()
        getLigandsFromFile()
        setLigands()
        ligandList.delegate = self
        ligandList.dataSource = self
        setSearchBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ligandViewController = segue.destination as! LigandViewController
        ligandViewController.ligand = currentLigandArr[selectedLigand].name
    }
    
    private func setSearchBar() {
        searchBar.delegate = self
    }
    
    private func getLigandsFromFile() {
        let fileURL = Bundle.main.path(forResource: "ligands", ofType: "txt")
        var fileContent = ""
        
        do {
            fileContent = try String(contentsOfFile: fileURL!, encoding: String.Encoding.utf8)
            ligFile = fileContent.components(separatedBy: "\n") as [String]
        } catch let error as NSError { //Why catch it as NSError???
            print("Failed to read ligands from file")
            print(error)
//            self.showAlert(title: "Error", message: "Failed to read from file", actionTitle: "Okay")
        }
    }
    
    private func containsOnlyLetters(input: String) -> Bool {
        for chr in input.characters {
            if !(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") {
                return false
            }
        }
        return true
    }
    
    private func setLigands() {
        for i in 0..<ligFile.count {
            if let _ = Int(ligFile[i]) {
                ligandArr.append(Ligand(_name: ligFile[i], _category: .allNum))
            } else if containsOnlyLetters(input: ligFile[i]) {
                ligandArr.append(Ligand(_name: ligFile[i], _category: .allText))
            } else {
                ligandArr.append(Ligand(_name: ligFile[i], _category: .all))
            }
        }
        currentLigandArr = ligandArr
    }
    
    //HANLE SEARCH BAR
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
        ligandList.reloadData()
    }
    
    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentLigandArr = ligandArr //get all ligands
        case 1:
            currentLigandArr = ligandArr
            currentLigandArr = currentLigandArr.filter({ ligand -> Bool in
                //get ligands with just text
                ligand.category == LigandType.allText
            })
        case 2:
            currentLigandArr = ligandArr
            currentLigandArr = currentLigandArr.filter({ ligand -> Bool in
                //get ligands with just number
                ligand.category == LigandType.allNum
            })
        default:
            break
        }
        ligandList.reloadData()
    }
    
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

}

extension SearchController: UITableViewDataSource, UITableViewDelegate {
    //TableViewControlls
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentLigandArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LigandCell") as? LigandCell else {
            return UITableViewCell()
        }
        cell.ligandName.text = currentLigandArr[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLigand = indexPath.row
        self.performSegue(withIdentifier: "DrawLigand", sender: self)
    }
}
