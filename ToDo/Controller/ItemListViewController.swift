//
//  ItemListViewController.swift
//  ToDo
//
//  Created by Ahmad medo on 21/08/2022.
//

import UIKit

class ItemListViewController: UIViewController, ItemManagerSettable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate &
                                 ItemManagerSettable)!
    var itemManager: ItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemManager = ItemManager()
        dataProvider.itemManager = itemManager
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetails(sender:)), name: Notification.Name("ItemSelectedNotification"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }
    @objc func showDetails(sender: Notification){
        guard let index = sender.userInfo?["index"] as? Int else{return}
        guard let itemManager = itemManager else {
            return
        }

        if let nextViewController = storyboard?.instantiateViewController(
            withIdentifier: "DetailViewController") as? DetailViewController{
            nextViewController.itemInfo = (itemManager, index)
            navigationController?.pushViewController(nextViewController,
                                                            animated: true)
            
        }else{
            return
        }
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
