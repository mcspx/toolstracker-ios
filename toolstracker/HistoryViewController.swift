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
import SDWebImage


class HistoryViewController: UIViewController , QRCodeReaderViewControllerDelegate , MGSwipeTableCellDelegate{
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
            let config = Config()
            ServiceRequest.sharedInstance.getTracking(result, url:config.tracking ,callback: {DataStatus in
                if(DataStatus == .Ready){
                    SVProgressHUD.dismiss()

                    let viewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
                    let realm = try! Realm()

                    let history = realm.objects(HistoryModel).last!

                    viewCtrl.trackingModel = history.tracking


                    self.presentViewController(viewCtrl, animated: true, completion: nil)

                }
                else{
                    SVProgressHUD.dismiss()
                    let alert = UIAlertController(title: "Error", message: "invalid Path", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)

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


        let condition1 = tracking[13].value
        let condition3 = tracking[15].value



        if(condition1 == "R"){
            cell.TATState.backgroundColor = UIColor.redColor()
        }
        if(condition1 == "G"){
            cell.TATState.backgroundColor = UIColor.greenColor()
        }
        if(condition1 == "Y"){
            cell.TATState.backgroundColor = UIColor.yellowColor()
        }
        if(condition1 == "X"){
            cell.TATState.backgroundColor = UIColor.whiteColor()
        }

        var img:UIImage!

        if(condition3 == "00"){
            img = UIImage(named: "00")
        }
        if(condition3 == "11"){
            img = UIImage(named: "11")
        }
        if(condition3 == "21"){
            img = UIImage(named: "21")
        }
        if(condition3 == "22"){
            img = UIImage(named: "22")
        }
        if(condition3 == "31"){
            img = UIImage(named: "31")
        }
        if(condition3 == "32"){
            img = UIImage(named: "32")
        }
        if(condition3 == "99"){
            img = UIImage(named: "99")
        }

        cell.imgState.image = img




        cell.lblHeader.text = serviceCode
        cell.lblDetail.text = regisTime
        cell.lblTATAll.text = TATAll
        cell.delegate = self
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor())]
        cell.rightSwipeSettings.transition = .Rotate3D
        return cell
    }

    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        let history = self.realm.objects(HistoryModel)[index]

        try! self.realm.write({
            self.realm.delete(history)
            self.tbvHistory.reloadData()
        })

        return true
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
