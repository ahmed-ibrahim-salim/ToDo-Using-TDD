//
//  InputViewController.swift
//  ToDo
//
//  Created by magdy khalifa on 25/08/2022.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {
    
    var dateFormatter: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }
    
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func save(){
        guard let titleString = titleTextField.text, titleString.count > 0 else { return }
        
        let date: Date?
        
        if let dateText = self.dateTextField.text,
           dateText.count > 0 {
            date = dateFormatter.date(from: dateText)
        } else {
            date = nil
        }
        
        let descriptionString = descriptionTextField.text
        
        if let locationName = locationTextField.text,
           locationName.count > 0 {
            if let address = addressTextField.text,
               address.count > 0 {
                geocoder.geocodeAddressString(address) {
                    (placeMarks, error) in
                    let placeMark = placeMarks?.first
                    let item = ToDoItem(
                        title: titleString,
                        itemDescription: descriptionString,
                        timestamp: date?.timeIntervalSince1970,
                        location: Location(
                            name: locationName,
                            coordinate: placeMark?.location?.coordinate))
                    self.itemManager?.add(item)
                }
            }
        }else{
            let itemWithNolocation = ToDoItem(
                title: titleString,
                itemDescription: descriptionString,
                timestamp: date?.timeIntervalSince1970,
                location: nil)
            self.itemManager?.add(itemWithNolocation)
        }
    }
}
