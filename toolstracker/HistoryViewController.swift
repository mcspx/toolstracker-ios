//
//  HistoryViewController.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/23/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit
import RealmSwift
import QRCodeReader
import AVFoundation
import SVProgressHUD

class HistoryViewController: UIViewController , QRCodeReaderViewControllerDelegate{
    @IBOutlet var tbvHistory: UITableView!
    lazy var reader: QRCodeReaderViewController = QRCodeReaderViewController(cancelButtonTitle: "Cancel", coderReader: QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode]), showTorchButton: true)

    let realm = try! Realm()
    @IBAction func pressClear(sender: AnyObject) {
        let alert = UIAlertController(title: "", message: "Do you want to clear?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in
            try! self.realm.write({
                 self.realm.delete(self.realm.objects(HistoryModel))
                self.tbvHistory.reloadData()
            })

        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .Cancel, handler: nil))

        presentViewController(alert, animated: true, completion: nil)

    }

    
    @IBAction func pressScan(sender: AnyObject) {
        if QRCodeReader.supportsMetadataObjectTypes() {
            reader.modalPresentationStyle = .FormSheet
            reader.delegate               = self
            presentViewController(reader, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))

            presentViewController(alert, animated: true, completion: nil)
        }

    }


    @IBAction func pressSetting(sender: AnyObject) {
        let viewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("SettingViewController")
        self.navigationController?.pushViewController(viewCtrl!, animated: true)
    }



    func reader(reader: QRCodeReaderViewController, didScanResult result: String) {
        self.dismissViewControllerAnimated(true, completion: {
            SVProgressHUD.showWithMaskType(.Black)
            ServiceRequest.sharedInstance.getTracking(result, callback: {DataStatus in
                if(DataStatus == .Ready){
                    SVProgressHUD.dismiss()

                    let viewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
                    let realm = try! Realm()

                    let history = realm.objects(HistoryModel).last!

                    viewCtrl.trackingModel = history.tracking


                    self.presentViewController(viewCtrl, animated: true, completion: nil)

                }
                else{

                }
            })
        })
    }

    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tbvHistory.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return realm.objects(HistoryModel).count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryTableViewCell", forIndexPath: indexPath) as! HistoryTableViewCell
        let tracking = realm.objects(HistoryModel)[indexPath.row].tracking
        let serviceCode = tracking[0].label
        let regisTime = tracking[8].value
        let TATAll = tracking[9].value

        cell.lblHeader.text = serviceCode
        cell.lblDetail.text = regisTime
        cell.lblTATAll.text = TATAll

//        cell.lblHeader.text = tracking.
        return cell
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
