//
//  StartViewController.swift
//  EvoNotes
//
//  Created by Marko Polietaiev on 5/18/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit
import RealmSwift

class StartViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var note: Note?
    var items: [Note] = []
    var filteredItems: [Note] = []
    let database = Database.shared()
    var searchActive: Bool = false
    var paginationFrom: Int = 0
    var paginationLimit: Int = 19

    override func viewDidLoad() {
        super.viewDidLoad()
        someSetupForVC()
        setupDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //hide keyboard after coming back from details view controller
        //P.S. yes, it is the best solution what I have found :)
        self.searchBar.endEditing(true)
    }
    
    func setupDataSource() {
        tableView.register(R.nib.noteTableViewCell)
        //PAGINATION
        if database.getNotesCount() >= paginationLimit {
            items = database.getNotes(from: paginationFrom, to: paginationLimit)
        } else {
            items = database.getNotes(from: nil, to: nil)
        }
        tableView.reloadData()
    }
    
    func someSetupForVC() {
        title = "Заметки"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let sort = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(sortTaped))
        navigationItem.rightBarButtonItems = [add, sort]
    }
    
    @objc func addTapped() {
        if let newViewController = R.storyboard.main.detailsViewController(){
            navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
}

//MARK: Sorting
extension StartViewController {
    @objc func sortTaped() {
        let alertController = UIAlertController(title: nil, message: "Каким образом хотите отсортировать?", preferredStyle: .actionSheet)
        
        let alphabet = UIAlertAction(title: "По алфавиту", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.sortByAlphabet()
        })
        let desc = UIAlertAction(title: "От новых к старым", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.sortNotesDesc()
        })
        let asc = UIAlertAction(title: "От старых к новым", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.sortNotesAsc()
        })
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(alphabet)
        alertController.addAction(desc)
        alertController.addAction(asc)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func sortByAlphabet() {
        items = items.sorted { $0.note < $1.note }
        tableView.reloadData()
    }
    
    func sortNotesDesc() {
        items = items.sorted { (obj1, obj2) -> Bool in
            return (obj1.date?.compare(obj2.date!) == .init(.orderedDescending))
        }
        tableView.reloadData()
    }
    
    func sortNotesAsc() {
        items = items.sorted { (obj1, obj2) -> Bool in
            return (obj1.date?.compare(obj2.date!) == .init(.orderedAscending))
        }
        tableView.reloadData()
    }
}

//MARK: Table View
extension StartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredItems.count
        }
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.noteTableViewCell, for: indexPath)!
        if (searchActive) {
            let note = filteredItems[row]
            cell.setupNote(note)
        } else {
            let note = items[row]
            cell.setupNote(note)
        }
        return cell
    }
    
    
}

extension StartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let note = items[row]
        if let newViewController = R.storyboard.main.detailsViewController(){
            searchBar.text = nil
            newViewController.note = note
            navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let note = items[row]
        if editingStyle == .delete {
            items.remove(at: row)
            tableView.deleteRows(at: [indexPath], with: .left)
            database.deleteNote(note)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //PAGINATION
        let row = indexPath.row
        if row == items.count - 1 {
            if database.getNotesCount() > paginationLimit {
                if items.count < paginationLimit {
                    //bring more notes
                    paginationFrom += 20
                    paginationLimit += 20
                    if database.getNotesCount() <= paginationLimit {
                        items.append(contentsOf: database.getNotes(from: paginationFrom, to: database.getNotesCount()))
                        self.perform(#selector(loadTable), with: nil, afterDelay: 0.5)
                    } else {
                        items.append(contentsOf: database.getNotes(from: paginationFrom, to: paginationLimit))
                        self.perform(#selector(loadTable), with: nil, afterDelay: 0.5)
                    }
                }

            }
        }
    }
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
}

//MARK: Search bar
extension StartViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredItems = items.filter({ (obj) -> Bool in
            let tmp: NSString = obj.note as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if (filteredItems.count == 0) {
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        searchActive = false;
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        tableView.reloadData()
    }
}


