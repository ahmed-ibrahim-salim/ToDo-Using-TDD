//
//  ItemListViewController.swift
//  ToDo
//
//  Created by Ahmad medo on 21/08/2022.
//

import UIKit

class ItemListViewController: UIViewController, ItemManagerSettable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: ItemListDataProvider!
    var itemManager: ItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        if let nextViewController =
            storyboard?.instantiateViewController(
                withIdentifier: "InputViewController")
            as? InputViewController {
            nextViewController.itemManager = itemManager
            
            present(nextViewController, animated: true, completion: nil)
        }
    }
}
