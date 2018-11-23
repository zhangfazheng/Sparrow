//
//  UserInfoModel.swift
//  Sparrow
//
//  Created by 张发政 on 2018/5/30.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit
import Argo
import Runes
import Curry

class UserInfoModel: NSObject {

    var name :String?
    var sex :String?
    var age :String?
    var address :String?
    
    
    init(name:String,sex:String,age:String,address:String) {
        self.name = name
        self.sex = sex
        self.age = age
        self.address = address
    }
    
    
    
}

extension UserInfoModel:Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<UserInfoModel> {
        return curry(UserInfoModel.init)
        <^> json <| "name"
        <*> json <| "sex"
        <*> json <| "age"
        <*> json <| "address"
    }
}
