//
//  ViewController.swift
//  BucketList
//
//  Created by Chucks Mac Book on 11/7/17.
//  Copyright © 2017 Chucks M/Users/chucksmacbook/Documents/CodingDojo/IOSapps/BucketList/BucketList/AddItemTableViewController.swiftac Book. All rights reserved.
//

import UIKit
import CoreData


class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate{
   
    var items = [BucketListItem]()
    // managedObjectContext = the container that will hold our data.
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            addItemTableViewController.item = item.text!
            addItemTableViewController.indexPath = indexPath
            
        }
       
    }
    
    func cancelButtonPressed(by Controller: AddItemTableViewController){
        dismiss(animated: true, completion: nil)
    }

    func itemSaved(by controller: AddItemTableViewController, with returnedtext: String?, at indexPath: NSIndexPath?) {
        if let idx = indexPath {
            print("received text", returnedtext!)
            let item = items[idx.row]
            item.text = returnedtext!
            //            items.append(returnedtext)
        } else {
            print("there is not index path", returnedtext!)
            // create item and insert it into the entityName
            // this will create an object that is of BucketListItem but you need to caste it to a bucketlistitem
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = returnedtext
            items.append(item)
        }
        //now we have to save the managedobject with all the changes
        // since the managedOject will have a "throw" method which is the error we have to do a DO statement:
        do {
            try managedObjectContext.save()
            print("THis should have saved")
        } catch {
            print("error: \(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    func fetchAllItems(){
        // setup a fetch request to get the data from teh db.
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")

        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
        
    }
    
    ///////////// these are required /////////////
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text
        return cell
    }
    /////////////////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "EditItem", sender: indexPath)
        print("selected")
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        /// if the row is tapped, then it will redirect to the the edit item segue.
        performSegue(withIdentifier: "EditItem", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //// this is the delete function /////////////////////////////////////////////////
        let item = items[indexPath.row] // set an item as a bucketlistitem
        /// then update the entity :
        managedObjectContext.delete(item) // i am guessing that it will traverse through the managedObject and delete the actual item (maybe by primary key)
        // then we need to commit it to the db
        do {
            try managedObjectContext.save()
        } catch {
            print("error: \(error)")
        }
        
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

