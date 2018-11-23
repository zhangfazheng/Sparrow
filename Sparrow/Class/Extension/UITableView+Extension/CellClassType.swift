//
//  CellClassType.swift
//  Sparrow
//
//  Created by 张发政 on 2018/1/29.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit

public class CellClassType: NSObject {

    let classString:String
    let reuseIdentifier :String
    
    /**
     *  Create a object that contain the classString and the reuseIdentifier.为cell添加自定义的重用标识符
     *
     *  @param classString     Class string.  cell的类名
     *  @param reuseIdentifier Cell reuseIdentifier  重用标识符
     *
     *  @return CellClassType Object.
     */
    init(classString:String,reuseIdentifier:String) {
        self.classString        = classString
        self.reuseIdentifier    = reuseIdentifier
    }
    
    public convenience init(classString:String){
        self.init(classString: classString, reuseIdentifier: classString)
    }
    
}
