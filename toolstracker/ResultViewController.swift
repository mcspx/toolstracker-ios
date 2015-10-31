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

    var filterTracking:Array<TrackingModel> = []

    var trackingModel = List<TrackingModel>()
    @IBOutlet var tbvResult: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(self.trackingModel)

        self.tbvResult.estimatedRowHeight = 100
        self.tbvResult.rowHeight = UITableViewAutomaticDimension

        for tracking in trackingModel{
            if(tracking.state != "F"){
                self.filterTracking.append(tracking)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultTableViewCell", forIndexPath: indexPath) as! ResultTableViewCell

        
        let tracking = filterTracking[indexPath.row]

        if(tracking.state == "T"){
            cell.lblHeader.text = tracking.label
            cell.lblDetail.text = tracking.value
        }

        
        
        return cell
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (filterTracking.count>0) ? filterTracking.count : 0
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
