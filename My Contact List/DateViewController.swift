//
//  DateViewController.swift
//  My Contact List
//
//  Created by Yovany Bartolome on 4/3/23.
//

import UIKit

protocol DateControllerDelegate: AnyObject {
    func dateChanged(date: Date)
}

class DateViewController: UIViewController {
    
    
    @IBOutlet weak var dtpDate: UIDatePicker!
    
    
    // Delegate may not always be set, so it's weak, and the type is optional (?)
    // Optional types are set to nil by default - no need for init methods
    weak var delegate: DateControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let saveButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveDate))
        
        self.navigationItem.rightBarButtonItem = saveButton
        self.title = "Pick Birthdate"
    }
    
    @objc func saveDate() {
        self.delegate?.dateChanged(date: dtpDate.date)
        self.navigationController?.popViewController(animated: true)
    }

}
