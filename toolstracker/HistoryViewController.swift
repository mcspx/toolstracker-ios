//
//  HistoryViewController.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/23/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBAction func pressClear(sender: AnyObject) {

    }

    
    @IBAction func pressScan(sender: AnyObject) {
        let viewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("QRCodeNavigation")
        self.presentViewController(viewCtrl!, animated: true, completion: nil)
    }


    @IBAction func pressSetting(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        ServiceRequest.sharedInstance.getTracking("A-TH-TH2015-10-00010", callback: {DataStatus in
            if(DataStatus == .Ready){

            }
        })
        // Do any additional setup after loading the view.
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
