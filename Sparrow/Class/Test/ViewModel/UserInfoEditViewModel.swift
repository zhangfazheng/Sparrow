//
//  UserInfoEditViewModel.swift
//  Sparrow
//
//  Created by 张发政 on 2018/5/30.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit
import Argo

class UserInfoEditViewModel: NSObject {

    var userEditArray :Array<CellDataAdapter<ZFZEditTileCellModel>>?
    
    override init() {
        //tilleString :String,valueString :String,units :String,strKey :String,keyBordType :UIKeyboardType
        let userJson:JSON = JSON(["name":"欧晧辰","age":"10","sex":"男","address":"北京"])
        
        let curUserDecode = UserInfoModel.decode(userJson)
        
        guard let curUser = curUserDecode.value else {
            return
        }
        
        let nameEditModel:ZFZEditTileCellModel = ZFZEditTileCellModel(tilleString: "姓名", valueString: curUser.name ?? "", units: "", strKey: "name", keyBordType: UIKeyboardType.default)
        
        let ageEdit :ZFZEditTileCellModel = ZFZEditTileCellModel(tilleString: "年龄", valueString: curUser.age ?? "", units: "", strKey: "age", keyBordType: UIKeyboardType.numberPad)
        
        
        let sexEdit :ZFZEditTileCellModel = ZFZEditTileCellModel(tilleString: "性别", valueString: curUser.sex ?? "", units: "", strKey: "sex", keyBordType: UIKeyboardType.numberPad)
        
        let addressEdit :ZFZEditTileCellModel = ZFZEditTileCellModel(tilleString: "地址", valueString: curUser.address ?? "", units: "", strKey: "address", keyBordType: UIKeyboardType.numberPad)
        
        let nameData = CellDataAdapter<ZFZEditTileCellModel>(cellReuseIdentifier: "ZFZValueTextCell", data: nameEditModel)
        
        let ageData = CellDataAdapter<ZFZEditTileCellModel>(cellReuseIdentifier: "ZFZValueTextCell", data: ageEdit)
        
        let sexData = CellDataAdapter<ZFZEditTileCellModel>(cellReuseIdentifier: "ZFZValueTextCell", data: sexEdit)
        
        
        let addressData = CellDataAdapter<ZFZEditTileCellModel>(cellReuseIdentifier: "ZFZValueTextCell", data: addressEdit)
        
        
        
        self.userEditArray = [nameData,ageData,sexData,addressData]
        
        
        
    }
    
}
