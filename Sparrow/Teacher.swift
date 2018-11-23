//
//  Teacher.swift
//  Sparrow
//
//  Created by 张发政 on 2018/1/23.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit
import Argo
import Curry
import Runes

class Teacher {

    var name:String?
    var age:Int = 0
    var subject:String?
    var sex:Int = 0
    var number :Int = 10;
    

    init(name:String,age:Int,subject:String,sex:Int,number:Int) {
        //super.init()
        self.name       = name
        self.age        = age
        self.subject    = subject
        self.sex        = sex
        self.number     = number

    }

}

extension Teacher:Argo.Decodable{
    static func decode(_ json: JSON) -> Decoded<Teacher> {
        return curry(Teacher.init)
        <^> json <| "name"
        <*> json <| "age"
        <*> json <| "subject"
        <*> json <| "sex"
        <*> json <| "number"

    }

}


