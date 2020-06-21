//
//  MoodViewController.swift
//  FirstPlate
//
//  Created by Maanav Khaitan on 20/06/20.
//  Copyright © 2020 Maanav Khaitan. All rights reserved.
//

import UIKit

var rowsWhichAreChecked = [NSIndexPath]()
var rowsWhichAreCheckedIndices = [Int]()

class MoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var checkListArray = ["Sweet", "Spicy", "Meat", "Seafood", "Vegan", "Asian", "Study Spot", "Fast Food", "Casual Dining", "Great Music", "Café", "Romantic"]


    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.allowsMultipleSelection = true

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkListArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.00
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.label.text = self.checkListArray[indexPath.row]
        let isRowChecked = rowsWhichAreChecked.contains(indexPath as NSIndexPath)
        
        if(isRowChecked == true)
        {
            //cell.checkBox.isChecked = true
            //cell.checkBox.buttonClicked(sender: cell.checkBox)
            cell.contentView.backgroundColor = UIColor.orange
        }else{
            //cell.checkBox.isChecked = false
            //cell.checkBox.buttonClicked(sender: cell.checkBox)
            cell.contentView.backgroundColor = UIColor.white
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! Cell
        cell.contentView.backgroundColor = UIColor.orange
        // cross checking for checked rows
        if(rowsWhichAreChecked.contains(indexPath as NSIndexPath) == false){
            //cell.checkBox.isChecked = true
            rowsWhichAreChecked.append(indexPath as NSIndexPath)
            rowsWhichAreCheckedIndices.append(indexPath.row)
            //cell.checkBox.buttonClicked(sender: cell.checkBox)
            
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! Cell
        //cell.checkBox.isChecked = false
        //cell.checkBox.buttonClicked(sender: cell.checkBox)
        cell.contentView.backgroundColor = UIColor.white
        // remove the indexPath from rowsWhichAreCheckedArray
        if let checkedItemIndex = rowsWhichAreChecked.firstIndex(of: indexPath as NSIndexPath){
            rowsWhichAreChecked.remove(at: checkedItemIndex)
            if let checkedRowItemIndex = rowsWhichAreCheckedIndices.firstIndex(of: indexPath.row){
                rowsWhichAreCheckedIndices.remove(at: checkedRowItemIndex)
            }
        }
        
    }
    
    @IBAction func recommendButtonClicked(_ sender: Any) {
        
        var userMoodLabels = [String]()
        for index in rowsWhichAreCheckedIndices {
            userMoodLabels.append(checkListArray[index])
        }
        UserDefaults.standard.set(userMoodLabels, forKey: "userMoodLabels")
        print(UserDefaults.standard.stringArray(forKey: "userMoodLabels"))
    }
    


}
