//
//  ServiceRequest.swift
//  toolstracker
//
//  Created by Jassadakorn Ketkaew on 10/23/15.
//  Copyright © 2015 Monchai Saipin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
class ServiceRequest: NSObject {

    static let sharedInstance = ServiceRequest()
    var isUseTestURL = false


    enum DataStatus : Int {
        case NotReady
        case Ready
        case Error

    }

    var manager = Alamofire.Manager.sharedInstance


    func getTracking(ssid:String ,var url:String , callback:(DataStatus) -> Void){
        let param = ["ssid": ssid]

 
        manager.session.configuration.timeoutIntervalForRequest = 10
        manager.request(.POST, url, parameters: param)
            .response(completionHandler: {(request , response , responseData , error) in
                if(error != nil){
                    callback(.Error)
                }

                guard let dataDic = JSON(data: responseData!).dictionary else{
                    callback(.Error)
                    return
                }



                if(dataDic["resultCode"]!.int! == 200){
                    let history = HistoryModel()
                    for trackDic in dataDic["resultData"]!.array!{
                        var tempValue = ""
                        if let order = trackDic["order"].int ,
                           let state = trackDic["state"].string,
                           let label = trackDic["label"].string{
                            if let valueTrack = trackDic["value"].string{
                                tempValue = valueTrack
                            }
                            else{
                                tempValue = "\(trackDic["value"].int!)"
                            }
                            let tracking = TrackingModel()
                            tracking.order = "\(order)"
                            tracking.state = state
                            tracking.label = label
                            tracking.value = tempValue


                            if(label == "Condition #1"){
                                history.condition1 = tempValue
                            }
                            if(label == "Condition #2"){
                                history.condition2 = tempValue
                            }
                            if(label == "Condition #3"){
                                history.condition3 = tempValue
                            }

                            if(label == "Service Code"){
                                history.serviceCode = tempValue
                            }
                            if(label == "Register Time"){
                                history.regisTime = tempValue
                            }
                            if(label == "TAT All"){
                                history.TATAll = tempValue
                            }




                            history.tracking.append(tracking)
                        }

                    }

                    let realm = try! Realm()
                    try! realm.write({
                        realm.add(history)
                    })
                     callback(.Ready)

                }else{
                    callback(.Error)
                }

            })

    }


    func checkPathCanUse(url:String , callback:(DataStatus) -> Void){


        manager.request(.GET, url+"/checking", parameters: nil)
            .response(completionHandler: {(request , response , responseData , error) in
                if(error != nil){
                    callback(.Error)
                }else{
                    guard let dataDic = JSON(data: responseData!).dictionary else{
                        callback(.Error)
                        return
                    }

                    if let resultCode = dataDic["resultCode"]{
                        if(resultCode == 200){
                            callback(.Ready)
                        }
                        else{
                            callback(.Error)
                        }
                    }
                    else{
                        callback(.Error)
                    }


                    callback(.Ready)
                }
            })
    }



}
