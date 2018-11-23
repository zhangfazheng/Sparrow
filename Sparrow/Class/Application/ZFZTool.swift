//
//  ZFZTool.swift
//  Sparrow
//
//  Created by 张发政 on 2018/5/23.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit

class ZFZTool: NSObject {

//    #if os(OSX)
//    //typealias Color = NSColor
//    #else
//    //typealias Color = UIColor
//    #endif
    // 当前系统版本
    let  version = (UIDevice.current.systemVersion as NSString).floatValue
    
    // 屏幕宽度
    open let screenHeight = UIScreen.main.bounds.height
    // 屏幕高度
    open let screenWidth = UIScreen.main.bounds.width
    // 默认图片
    let defaultImg = UIImage(named: "photo_define")
    // NSUserDefault
    let userDefault = UserDefaults.standard
    // 通知中心
    let notice = NotificationCenter.default
    //判断是不是plus
    let currentModeSize = UIScreen.main.currentMode?.size
    
    //去除空格
    func trimString(str:String)->String{
        let nowStr = str.trimmingCharacters(in: CharacterSet.whitespaces)
        return nowStr
    }
    
    //去除空格和回车
    func trimLineString(str:String)->String{
        var nowStr = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return nowStr
    }
    
    //根据键盘监控  获取键盘高度
    func getKeyBoardHeight(aNotification:Notification)->CGFloat{
        var uInfo   = aNotification.userInfo as Dictionary?
        let avalue = uInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue
        let keyrect : CGRect = avalue.cgRectValue
        let keyheight : CGFloat = keyrect.size.height;
        return keyheight
    }
    //获取目录下存储的json文件并解析为集合
    func getNativeJson(filename : String,fileext : String)->AnyObject{
        let pathsBun = Bundle.main
        let paths = pathsBun.path(forResource: filename, ofType : fileext)
        //var errors:NSError?
        var content : Data = try! Data(contentsOf: URL(fileURLWithPath: paths!), options: Data.ReadingOptions.mappedIfSafe)
        
        var returneddata  = try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)
        return returneddata! as AnyObject
    }
    //消息提醒
//    func showAlertView(title:String,message:String)
//    {
//        var alert = UIAlertView()
//        alert.title = title
//        alert.message = message
//        alert.addButtonWithTitle("好")
//        alert.show()
//    }
    //获取本地存储数据
    func get_userDefaults(key : String)->AnyObject?{
        
        var saveStr = userDefault.object(forKey: key)
        saveStr = (saveStr == nil) ? "" : saveStr
        return saveStr as AnyObject
    }
    //存储数据
    func save_userDefaults(key : String,value:AnyObject?){
        userDefault.setValue(value, forKey: key)
    }
    //字符串转数组
    func stringToArray(str:String)->Array<Any>{
        var dataArray:[String] = []
        for items in str{
            dataArray.append("\(items)")
        }
        return dataArray as Array
    }
    
    func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor {
        
        return UIColor(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
        
    }
    
    
    //最大值
    class func Max(a:CGFloat,b:CGFloat) -> CGFloat {
        if a > b {
            return a
        }else{
            return b
        }
        
    }
    
    //最小值
    class func Min(a:CGFloat,b:CGFloat) -> CGFloat{
        if a > b {
            return b
        }else{
            return a
        }
        
    }
    
}
