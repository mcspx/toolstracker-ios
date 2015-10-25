//
//  ResultViewController.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/23/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit
import RealmSwift

class ResultViewController: UIViewController {



    
    @IBAction func pressHistory(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    


    var trackingModel = List<TrackingModel>()
    @IBOutlet var tbvResult: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tbvResult.estimatedRowHeight = 100
        self.tbvResult.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultTableViewCell", forIndexPath: indexPath) as! ResultTableViewCell

        
        let tracking = trackingModel[indexPath.row]

        if(tracking.state == "T"){
            cell.lblHeader.text = tracking.label
            cell.lblDetail.text = tracking.value
        }

        
        
        return cell
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (trackingModel.count>0) ? trackingModel.count : 0
    }

//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
//        return true
//    }
//
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
//
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
