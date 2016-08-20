//
//  MenuViewController.swift
//  Medical_App
//
//  Created by Gregory Johnson on 8/18/16.
//  Copyright © 2016 Gregory Johnson. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "MyDataTableViewCell"
    let cellExpandHeight:CGFloat = 300
    let cellDefaultHeight:CGFloat = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(white: 0.0, alpha: 0)        
        loadData()
    }
    
    func loadData()
    {
        if(cells.count == 0)
        {
            print("Loading")
            let img1 = UIImage(named: "data")!
            let cell1 = cellData(title: "Personal Data", image: img1, storyboardId: "PersonalInfo")
            
            let img2 = UIImage(named: "data")!
            let cell2 = cellData(title: "Insurance Data", image: img2, storyboardId: "PersonalInfo")
            
            let img3 = UIImage(named: "data")!
            let cell3 = cellData(title: "Next of Kin Data", image: img3, storyboardId: "PersonalInfo")
            
            cells += [cell1, cell2, cell3]
            cellHeights += [cellDefaultHeight, cellDefaultHeight, cellDefaultHeight]
        }
        else
        {
            for i in 0 ..< cells.count
            {
                cellHeights[i] = cellDefaultHeight
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return cellHeights[indexPath.section]
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Number of cells in the section
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //cell coding
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MyDataTableViewCell
        let thisCell = cells[indexPath.section]
        cell.im_icon = UIImageView(image: thisCell.image)
        cell.l_title.text = thisCell.title
        cell.layer.cornerRadius = 30
        
        return cell
    }
    
    //Called when button is pressed when the table view has expanded
    func pushNext(sender:UIButton)
    {
        let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier(cells[sender.tag].storyboardId)
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //When selected
        cellHeights[indexPath.section] = cellHeights[indexPath.section] == self.cellExpandHeight ? cellDefaultHeight : self.cellExpandHeight
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MyDataTableViewCell
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if(cellHeights[indexPath.section] == cellExpandHeight) //is expanded
        {
            
            let newButton = UIButton(frame: cell.v_buttonPos.frame)
            newButton.setTitle("Input Info", forState: UIControlState.Normal)
            newButton.titleLabel!.font = UIFont(name: (newButton.titleLabel!.font?.fontName)!, size: 20)
            newButton.tag = indexPath.section
            newButton.addTarget(self, action: #selector(MenuViewController.pushNext(_:)), forControlEvents: .TouchUpInside)
            
            cell.addSubview(newButton)
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    @IBAction func addCells(sender: AnyObject) {
    
        let img1 = UIImage(named: "data")!
        let newCell = cellData(title: "New Data", image: img1, storyboardId: "PersonalInfo")
        
        cells += [newCell]
        cellHeights += [cellDefaultHeight]
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
