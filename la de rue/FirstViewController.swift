//
//  FirstViewController.swift
//  la de rue
//
//  Created by Spencer Bull on 7/11/15.
//  Copyright (c) 2015 bullapse. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // list of food truck objects from Web Service
    var foodTrucks = NSMutableArray()
    
    let textCellIdentifier = "TextCell"
//    
//    let truckNames = ["Didn't work"]
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        
        
    }
    
    @IBAction func loadTableView(sender: AnyObject) {
        loadFoodTrucks()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodTrucks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
        }
        
        let foodTruck:JSON = JSON(self.foodTrucks[indexPath.row])

        
        return cell!
    }
    
    func loadFoodTrucks() {
        print("in loadFoodTrucks")
        RESTAPIManager.sharedInstance.getTruckNames { json -> Void in
            let results = json["results"]
            for (index: String, subJson: JSON) in results {
                let foodTruckName: AnyObject = subJson["Name"].object

            }
        }
    }

    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(foodTrucks[row])
    }
    
}

