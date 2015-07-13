//
//  FirstViewController.swift
//  la de rue
//
//  Created by Spencer Bull on 7/11/15.
//  Copyright (c) 2015 bullapse. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var foodTruckList: [JSON] = []

    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadFoodTrucks()
        
    }
    
    @IBAction func loadTableView(sender: AnyObject) {
        loadFoodTrucks()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodTruckList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        let data = foodTruckList[indexPath.row]
        let name = data["Name"].string
        let isOpen = data["isOpen"].string
        var caption = "Closed"
        if (isOpen == "1") {
            caption = "Open"
        }
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = caption
        
        
        return cell
    }
    
    func loadFoodTrucks() {
        Alamofire.request(.GET, "http://localhost:4730")
            .responseJSON { (_, _, json, _) in
                if json != nil {
                    var jsonObj = JSON(json!)
                    if let data = jsonObj["results"].arrayValue as [JSON]?{
                        self.foodTruckList = data
                        self.tableView.reloadData()
                        print(self.foodTruckList)
                    }
                }
                
                
                
        }
        
        
    }

    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        // prints the whole JSON object to the console. 
        // foodTruckList[row] return the object
        print(foodTruckList[row])
    }
    
}

