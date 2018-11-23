//
//  ZFZEditTileCellModel.swift
//  Sparrow
//
//  Created by 张发政 on 2018/3/23.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit
import ReactiveSwift
import Runes
import Result
//import Argo
//import Curry

class ZFZEditTileCellModel: NSObject {
    var tilleString :String?
    var valueString :String
    var units :String?
    var strKey :String?
    var keyBordType :UIKeyboardType?
    var valueSignal :Signal<String, NoError>?
    
    init(tilleString :String,valueString :String,units :String,strKey :String,keyBordType :UIKeyboardType) {
        self.tilleString    = tilleString
        self.valueString    = valueString
        self.units          = units
        self.strKey         = strKey
        self.keyBordType    = keyBordType
    }

    init(tilleString :String,valueString :String,units :String,strKey :String,keyBordType :UIKeyboardType , valueSignal:Signal<String, NoError>) {
        self.tilleString    = tilleString
        self.valueString    = valueString
        self.units          = units
        self.strKey         = strKey
        self.keyBordType    = keyBordType
        self.valueSignal    = valueSignal
    }
    
    
}


//extension ZFZEditTileCellModel:Argo.Decodable{
//    static func decode(_ json: JSON) -> Decoded<ZFZEditTileCellModel> {
//        return curry(ZFZEditTileCellModel.init)
//        <^> json <| "tilleString"
//        <*> json <| "valueString"
//        <*> json <| "units"
//        <*> json <| "strKey"
//        <*> json <| "keyBordType"
//    }
//}



