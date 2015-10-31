//
//  SettingViewController.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/25/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire


class SettingViewController: UIViewController {

    @IBAction func pressSave(sender: AnyObject) {
        SVProgressHUD.showWithMaskType(.Black)
        ServiceRequest.sharedInstance.checkPathCanUse(self.txtFieldUrl.text! , callback: { dataStatus in
            SVProgressHUD.dismiss()
            if(dataStatus == .Ready){
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(self.txtFieldUrl.text, forKey: "saveURLKey")
                let alert = UIAlertController(title: "", message: "Service Ready!", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Error", message: "invalid Path", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Close", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }
    @IBOutlet var txtFieldUrl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let url = defaults.objectForKey(Config.sharedInstance.saveURLKey){
            self.txtFieldUrl.text = url as? String
        }
        else{
            self.txtFieldUrl.text = "http://api.echeck-tools.com"
        }
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
