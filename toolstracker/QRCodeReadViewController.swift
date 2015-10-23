//
//  QRCodeReadViewController.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/23/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit

class QRCodeReadViewController: UIViewController {

    @IBAction func testPress(sender: AnyObject) {
        let viewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
        print(viewCtrl)
        self.navigationController?.pushViewController(viewCtrl, animated: true)
    }

    @IBAction func pressCancel(sender: AnyObject) {
             self.dismissViewControllerAnimated(true, completion: nil)
    }
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
