//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by Ahmad medo on 21/08/2022.
//

import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
