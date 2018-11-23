//
//  BaseCell.swift
//  Sparrow
//
//  Created by 张发政 on 2018/1/29.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit

//protocol BaseCell {
//    associatedtype T
//
//    var dataAdapter:CellDataAdapter<T>{get set}
//    var data : T?{get set}
//    var indexPath : IndexPath?{get set}
//    var tableView : UITableView?{get set}
//    var controller : UIViewController?{get set}
//    var display :Bool{get set}
//
//    func setupCell()
//
//    func loadContent()
//
//}
//
//
//extension UITableViewCell:BaseCell{
//    typealias T = D
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.bindViewModel()
//        self.setupCell()
//        self.buildSubview()
//    }
//
//    var dataAdapter:CellDataAdapter<T>?
//    var data : T?
//    var indexPath : IndexPath?
//    var tableView : UITableView?
//    var controller : UIViewController?
//    var display :Bool = false
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.bindViewModel()
//        self.setupCell()
//        self.buildSubview()
//    }
//
//    public func setWeakReference(cellDataAdapter: CellDataAdapter<T>, data:T
//        ,indexPath:IndexPath,tableView:UITableView) {
//        self.dataAdapter        = cellDataAdapter
//        self.data               = data
//        self.indexPath          = indexPath
//        self.tableView          = tableView
//    }
//
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    public func setupCell(){
//
//    }
//
//    public func buildSubview(){
//
//    }
//
//
//    public func loadContent(){
//
//    }
//
//    public func bindViewModel(){
//
//    }
//
//
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//
//    /**
//     *  Calculate the cell's from data, override by subclass.
//     *
//     *  @param data Data.
//     *
//     *  @return Cell's height.
//     */
//    class func cellHeightWithData(data:T) -> CGFloat{
//        return 0
//    }
//
//    //MARK:  - Useful method.
//
//    /**
//     *  Update the cell's height with animated or not, before you use this method, you should have the weak reference 'tableView' and 'dataAdapter', and this method will update the weak reference dataAdapter's property cellHeight.
//     *
//     *  @param height   The new cell height.
//     *  @param animated Animated or not.
//     */
//    func updateWithNewCellHeight(height:CGFloat,animated:Bool) {
//
//    }
//
//
//    /**
//     *  Selected event, you should use this method in 'tableView:didSelectRowAtIndexPath:' to make it effective.
//     */
//    func selectedEvent(){
//
//    }
//
//    //MARK: - Constructor method.
//
//    /**
//     *  Create the cell's dataAdapter.
//     *
//     *  @param reuseIdentifier Cell reuseIdentifier, can be nil.
//     *  @param data            Cell's data, can be nil.
//     *  @param height          Cell's height.
//     *  @param type            Cell's type.
//     *
//     *  @return Cell's dataAdapter.
//     */
//    class func dataAdapterWithCellReuseIdentifier(reuseIdentifier:String?,data:T,cellHeight:CGFloat,type:Int) -> CellDataAdapter<T> {
//        if let tmpReuseIdentifier :String = reuseIdentifier {
//            return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: 0, cellType: type)
//        }else{
//
//            let tmpReuseIdentifier = NSStringFromClass(self.classForCoder())
//            return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: 0, cellType: type)
//        }
//
//    }
//
//    /**
//     *  Create the cell's dataAdapter.
//     *
//     *  @param reuseIdentifier Cell reuseIdentifier, can be nil.
//     *  @param data            Cell's data, can be nil.
//     *  @param height          Cell's height.
//     *  @param cellWidth       Cell's width.
//     *  @param type            Cell's type.
//     *
//     *  @return Cell's dataAdapter.
//     */
//    class func dataAdapterWithCellReuseIdentifier(reuseIdentifier:String?,data:T,cellHeight:CGFloat,cellWidth:CGFloat, type:Int) -> CellDataAdapter<T> {
//        if let tmpReuseIdentifier :String = reuseIdentifier {
//            return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: cellWidth, cellType: type)
//        }else{
//
//            let tmpReuseIdentifier = NSStringFromClass(self.classForCoder())
//            return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: cellWidth, cellType: type)
//        }
//    }
//
//
//    /**
//     *  Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.
//     *
//     *  @param data            Cell's data, can be nil.
//     *  @param height          Cell's height.
//     *  @param type            Cell's type.
//     *
//     *  @return Cell's dataAdapter.
//     */
//    class func dataAdapterWithData(data:T,cellHeight:CGFloat,type:Int) -> CellDataAdapter<T> {
//        let tmpReuseIdentifier = NSStringFromClass(self.classForCoder())
//        return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: 0, cellType: type)
//    }
//
//    /**
//     *  Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.
//     *
//     *  @param data            Cell's data, can be nil.
//     *  @param height          Cell's height.
//     *
//     *  @return Cell's dataAdapter.
//     */
//    class func dataAdapterWithData(data:T,cellHeight:CGFloat) -> CellDataAdapter<T> {
//        let tmpReuseIdentifier = NSStringFromClass(self.classForCoder())
//        return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: 0, cellType: 0)
//    }
//
//
//    /**
//     *  Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.
//     *
//     *  @param data            Cell's data, can be nil.
//     *
//     *  @return Cell's dataAdapter.
//     */
//    class func dataAdapterWithData(data:T) -> CellDataAdapter<T> {
//        let tmpReuseIdentifier = NSStringFromClass(self.classForCoder())
//        return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data)
//    }
//
//
//    /**
//     *  Convenient method to set some weak reference.
//     *
//     *  @param dataAdapter CellDataAdapter's object.
//     *  @param data        Data.
//     *  @param indexPath   IndexPath.
//     *  @param tableView   TableView.
//     */
//    func setWeakReferenceWithCellDataAdapter(dataAdapter:CellDataAdapter<T>,data:T?,indexPath:IndexPath,tableView:UITableView) {
//        self.dataAdapter        = dataAdapter
//        self.data               = data
//        self.indexPath          = indexPath
//        self.tableView          = tableView
//    }
//
//
//    /**
//     *  Register to tableView with the reuseIdentifier you specified.
//     *
//     *  @param tableView       TableView.
//     *  @param reuseIdentifier The cell reuseIdentifier.
//     */
//    class func registerToTableView(tableView:UITableView,reuseIdentifier:String) {
//        tableView .register(self.classForCoder(), forCellReuseIdentifier: reuseIdentifier)
//    }
//
//
//    /**
//     *  Register to tableView with the The class name.
//     *
//     *  @param tableView       TableView.
//     */
//    class func registerToTableView(tableView:UITableView) {
//        tableView .register(self.classForCoder(), forCellReuseIdentifier: NSStringFromClass(self.classForCoder()))
//    }
//
//    //去除cell的选中效果
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        //        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//}



class BaseCell<T>: UITableViewCell {

    var dataAdapter:CellDataAdapter<T>?
    var data : T?
    var indexPath : IndexPath?
    var tableView : UITableView?
    var controller : UIViewController?
    var display :Bool = false

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.bindViewModel()
        self.setupCell()
        self.buildSubview()
    }

    public func setWeakReference(cellDataAdapter: CellDataAdapter<T>, data:T
        ,indexPath:IndexPath,tableView:UITableView) {
        self.dataAdapter        = cellDataAdapter
        self.data               = data
        self.indexPath          = indexPath
        self.tableView          = tableView
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    public func setupCell(){

    }

    public func buildSubview(){

    }


    public func loadContent(){

    }

    public func bindViewModel(){

    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    /**
     *  Calculate the cell's from data, override by subclass.
     *
     *  @param data Data.
     *
     *  @return Cell's height.
     */
    class func cellHeightWithData(data:T) -> CGFloat{
        return 0
    }

    //MARK:  - Useful method.

    /**
     *  Update the cell's height with animated or not, before you use this method, you should have the weak reference 'tableView' and 'dataAdapter', and this method will update the weak reference dataAdapter's property cellHeight.
     *
     *  @param height   The new cell height.
     *  @param animated Animated or not.
     */
    func updateWithNewCellHeight(height:CGFloat,animated:Bool) {

    }


    /**
     *  Selected event, you should use this method in 'tableView:didSelectRowAtIndexPath:' to make it effective.
     */
    func selectedEvent(){

    }

    //MARK: - Constructor method.

    /**
     *  Create the cell's dataAdapter.
     *
     *  @param reuseIdentifier Cell reuseIdentifier, can be nil.
     *  @param data            Cell's data, can be nil.
     *  @param height          Cell's height.
     *  @param type            Cell's type.
     *
     *  @return Cell's dataAdapter.
     */
    class func dataAdapterWithCellReuseIdentifier(reuseIdentifier:String?,data:T,cellHeight:CGFloat,type:Int) -> CellDataAdapter<T> {
        if let tmpReuseIdentifier :String = reuseIdentifier {
            return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: 0, cellType: type)
        }else{

            let tmpReuseIdentifier = NSStringFromClass(self.classForCoder())
            return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: 0, cellType: type)
        }

    }

    /**
     *  Create the cell's dataAdapter.
     *
     *  @param reuseIdentifier Cell reuseIdentifier, can be nil.
     *  @param data            Cell's data, can be nil.
     *  @param height          Cell's height.
     *  @param cellWidth       Cell's width.
     *  @param type            Cell's type.
     *
     *  @return Cell's dataAdapter.
     */
    class func dataAdapterWithCellReuseIdentifier(reuseIdentifier:String?,data:T,cellHeight:CGFloat,cellWidth:CGFloat, type:Int) -> CellDataAdapter<T> {
        if let tmpReuseIdentifier :String = reuseIdentifier {
            return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: cellWidth, cellType: type)
        }else{

            let tmpReuseIdentifier = NSStringFromClass(self.classForCoder())
            return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: cellWidth, cellType: type)
        }
    }


    /**
     *  Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.
     *
     *  @param data            Cell's data, can be nil.
     *  @param height          Cell's height.
     *  @param type            Cell's type.
     *
     *  @return Cell's dataAdapter.
     */
    class func dataAdapterWithData(data:T,cellHeight:CGFloat,type:Int) -> CellDataAdapter<T> {
        let tmpReuseIdentifier = NSStringFromClass(self.classForCoder())
        return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: 0, cellType: type)
    }

    /**
     *  Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.
     *
     *  @param data            Cell's data, can be nil.
     *  @param height          Cell's height.
     *
     *  @return Cell's dataAdapter.
     */
    class func dataAdapterWithData(data:T,cellHeight:CGFloat) -> CellDataAdapter<T> {
        let tmpReuseIdentifier = NSStringFromClass(self.classForCoder())
        return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data, cellHeight: cellHeight, cellWidth: 0, cellType: 0)
    }


    /**
     *  Create the cell's dataAdapter, the CellReuseIdentifier is the cell's class string.
     *
     *  @param data            Cell's data, can be nil.
     *
     *  @return Cell's dataAdapter.
     */
    class func dataAdapterWithData(data:T) -> CellDataAdapter<T> {
        let tmpReuseIdentifier = NSStringFromClass(self.classForCoder())
        return CellDataAdapter(cellReuseIdentifier: tmpReuseIdentifier, data: data)
    }


    /**
     *  Convenient method to set some weak reference.
     *
     *  @param dataAdapter CellDataAdapter's object.
     *  @param data        Data.
     *  @param indexPath   IndexPath.
     *  @param tableView   TableView.
     */
    func setWeakReferenceWithCellDataAdapter(dataAdapter:CellDataAdapter<T>,data:T?,indexPath:IndexPath,tableView:UITableView) {
        self.dataAdapter        = dataAdapter
        self.data               = data
        self.indexPath          = indexPath
        self.tableView          = tableView
    }


    /**
     *  Register to tableView with the reuseIdentifier you specified.
     *
     *  @param tableView       TableView.
     *  @param reuseIdentifier The cell reuseIdentifier.
     */
    class func registerToTableView(tableView:UITableView,reuseIdentifier:String) {
        tableView .register(self.classForCoder(), forCellReuseIdentifier: reuseIdentifier)
    }


    /**
     *  Register to tableView with the The class name.
     *
     *  @param tableView       TableView.
     */
    class func registerToTableView(tableView:UITableView) {
        tableView .register(self.classForCoder(), forCellReuseIdentifier: NSStringFromClass(self.classForCoder()))
    }

    //去除cell的选中效果
    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
