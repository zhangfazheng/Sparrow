//
//  StudentModel.swift
//  Sparrow
//
//  Created by 张发政 on 2018/1/23.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

struct Student {
    var name:String
    var age:Int
    var sex:Int
    var number:Int
    
    init(name:String,age:Int,sex:Int,number:Int) {
        self.name   = name
        self.age    = age
        self.sex    = sex
        self.number = number
    }
    
}


extension Student:Argo.Decodable{
    static func decode(_ json: JSON) -> Decoded<Student> {
        return curry(Student.init)
        <^> json <| "name"
        <*> json <| "age"
        <*> json <| "sex"
        <*> json <| "number"
    }
    
    
}
