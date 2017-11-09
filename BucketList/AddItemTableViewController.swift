//
//  AddItemTableViewController.swift
//  BucketList
//
//  Created by Chucks Mac Book on 11/7/17.
//  Copyright © 2017 Chucks Mac Book. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    @IBOutlet weak var itemTextField: UITextField!
    var item: String?
    var indexPath: NSIndexPath?
    
    
    weak var delegate: AddItemTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    @IBAction func savedButtonPressed(_ sender: UIBarButtonItem) {
        let text = String(describing: itemTextField.text!)
        if let ip = indexPath {
            delegate?.itemSaved(by: self, with: text, at: ip)
        } else {
            delegate?.itemSaved(by: self, with: text, at: nil)
        }
        
        //print(String(describing: itemTextField.text), "RTWERTWERTWERT")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
