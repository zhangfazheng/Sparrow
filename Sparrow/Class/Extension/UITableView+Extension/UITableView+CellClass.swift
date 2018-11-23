//
//  UITableView+CellClass.swift
//  Sparrow
//
//  Created by 张发政 on 2018/1/29.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import Foundation
import UIKit



extension UITableView{
    /**
     *  Register cells class.
     *
     *  @param cellClasses CellClassType object's array.
     */
    func registerCellsClass(cellClasses:Array<CellClassType>) {
        for cellClass:CellClassType in cellClasses {
            self.register(NSClassFromString(cellClass.classString), forCellReuseIdentifier: cellClass.reuseIdentifier)
        }
    }
    
    
    
    /**
     *  用cell模型创建一个cell.
     *
     *  @param adapter CellClassType object's array.
     */
    func dequeueAndLoadContentReusableCellFromAdapter<T>(_ adapter:CellDataAdapter<T>,indexPath:IndexPath) -> BaseCell<T>? {
        let cell:BaseCell<T>? = self.dequeueReusableCell(withIdentifier: adapter.cellReuseIdentifier) as? BaseCell<T>
        cell?.setWeakReferenceWithCellDataAdapter(dataAdapter: adapter, data: adapter.data, indexPath: indexPath, tableView: self)
        cell?.loadContent()
        return cell
    }
    
    
    /**
     *  Register cells class.
     *
     *  @param adapter CellClassType object's array.
     */
    func dequeueAndLoadContentReusableCellFromAdapter<T>(adapter:CellDataAdapter<T>,indexPath:IndexPath, controller:UIViewController) -> BaseCell<T>? {
        
        let reuseIdentifier = adapter.cellReuseIdentifier
        
        let cell:BaseCell<T>? = self.dequeueReusableCell(withIdentifier:reuseIdentifier) as? BaseCell<T>
        
        cell?.controller = controller;
        cell?.setWeakReferenceWithCellDataAdapter(dataAdapter: adapter, data: adapter.data, indexPath: indexPath, tableView: self)
        cell?.loadContent()
        
        return cell
    }
    
    func abcd<T>(add:CellDataAdapter<T>) -> String {
        print(add.cellReuseIdentifier)
        return add.cellReuseIdentifier
    }
}
