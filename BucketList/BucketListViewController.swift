//
//  ViewController.swift
//  BucketList
//
//  Created by Chucks Mac Book on 11/7/17.
//  Copyright © 2017 Chucks M/Users/chucksmacbook/Documents/CodingDojo/IOSapps/BucketList/BucketList/AddItemTableViewController.swiftac Book. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate{
   
    var items = ["go to moon", "golf", "enjoy life", "swim", "ride an atv"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "EditItem", sender: indexPath)
        print("selected")
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            // create an instance of the UINavigationController but it is a segue.desitination that was casted
            let navigationController = segue.destination as! UINavigationController
            //from this navigationController.topViewController cast as the additemtableviewControllers.
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            //from this controller get the delegate and set it up as the instance of teh THIS view controller.
            addItemTableViewController.delegate = self
        } else if segue.identifier == "EditItem"{
            // create an instance of the UINavigationController but it is a segue.desitination that was casted
            let navigationController = segue.destination as! UINavigationController
            //from this navigationController.topViewController cast as the additemtableviewControllers.
            let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            //from this controller get the delegate and set it up as the instance of teh THIS view controller.
             addItemTableViewController.delegate = self
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableViewController.item = item
            addItemTableViewController.indexPath = indexPath
            
        }
       
    }
    
    func cancelButtonPressed(by Controller: AddItemTableViewController){
        print("I'm the hiddencontroller,")
        dismiss(animated: true, completion: nil)
    }

    func itemSaved(by controller: AddItemTableViewController, with returnedtext: String, at indexPath: NSIndexPath?) {
        
        if let idx = indexPath {
            print("received text", returnedtext)
            items[idx.row] = returnedtext
            //            items.append(returnedtext)
        } else {
            print("there is not index path", returnedtext)
            items.append(returnedtext)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
}

