//
//  CellDataAdapter.swift
//  Sparrow
//
//  Created by 张发政 on 2018/1/25.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit


/**
 *  Cell的数据模型对象，为每一个cell创建一个模型，当cell加载的时候不需要判断某个indexPath展示某个cell,cell自动根据该对象加载指定cell
 */
class CellDataAdapter<T> {

    let cellReuseIdentifier :String
    var data :T?
    var cellHeight:CGFloat
    var cellWidth :CGFloat
    let cellType :Int
    let tableView : UITableView?
    let collectionView : UICollectionView?
    let indexPath : IndexPath?
    
    
    init(cellReuseIdentifier:String,data:T,cellHeight:CGFloat,cellWidth:CGFloat,cellType:Int) {
        self.cellReuseIdentifier    = cellReuseIdentifier
        self.data                   = data
        self.cellWidth              = cellWidth
        self.cellHeight             = cellHeight
        self.cellType               = cellType
        
        self.tableView              = nil
        self.collectionView         = nil
        self.indexPath              = nil
    }
    
    public convenience init(cellReuseIdentifier:String,data:T,cellType:Int) {
        self.init(cellReuseIdentifier: cellReuseIdentifier, data: data, cellHeight: 0, cellWidth: 0, cellType: cellType)
    }
    
    
    public convenience init(cellReuseIdentifier:String,data:T) {
        self.init(cellReuseIdentifier: cellReuseIdentifier, data: data, cellHeight: 0, cellWidth: 0, cellType: 0)
    }
}
