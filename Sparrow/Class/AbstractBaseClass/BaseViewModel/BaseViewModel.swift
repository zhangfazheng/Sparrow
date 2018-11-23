//
//  BaseViewModel.swift
//  Sparrow
//
//  Created by 张发政 on 2018/3/23.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result


enum TitleViewType {
    case TitleViewTypeDefault
    case TitleViewTypeDoubleTitle
    case TitleViewTypeLoadingTitle
}

class BaseViewModel<Model>: NSObject {
    var service:Any?
    var params:Dictionary<String, Any>?
    var title:String?
    var titleViewType:TitleViewType = .TitleViewTypeDefault
    var subtitle:String?
    var shouldFetchLocalDataOnViewModelInitialize:Bool = false
    var shouldRequestRemoteDataOnViewDidLoad :Bool = false
    var activeStatus = MutableProperty(false)
    var requestDataAction:Action<Any,Any,AnyError>?
    var willDisappearSignal:Signal<Bool,AnyError>?
    var willDisappearObserver:Signal<Bool,AnyError>.Observer?
    
    
    
    override init() {
        super.init()
        self.initialize()
    }

    convenience init(service:Any,params:Dictionary<String, Any>) {
        self.init()
        
       let (signal,observer) = Signal<Bool,AnyError>.pipe()
        
        willDisappearSignal = signal
        willDisappearObserver = observer
        
        self.initialize()
        self.title = params["title"] as? String
        self.service = service
        self.params = params
        
        requestDataAction = Action<Any,Any,AnyError>(execute: { (input) -> SignalProducer<Any, AnyError> in
            return self.executeRequestDataProducer(input: input)
        })
        
    }
    
    //若要实现网络数据请求需实现些方法
    func executeRequestDataProducer(input:Any) -> SignalProducer<Any, AnyError> {
        return SignalProducer<Any, AnyError>.empty
    }
    
    func initialize() -> Void {
        
    }
    
}
