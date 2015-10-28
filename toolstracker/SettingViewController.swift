//
//  SettingViewController.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/25/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBAction func pressSave(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(txtFieldUrl.text, forKey: "saveURLKey")
        let alert = UIAlertController(title: "", message: "Save Sucessful", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))

        presentViewController(alert, animated: true, completion: nil)

    }
    @IBOutlet var txtFieldUrl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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
