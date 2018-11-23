//
//  LoadingTitleView.swift
//  Sparrow
//
//  Created by 张发政 on 2018/5/31.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit
import SnapKit

class LoadingTitleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    
    lazy var activeView :UIActivityIndicatorView = {
        let activew:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        activew.startAnimating()
        return activew
    }()
    
    lazy var loadingLable:UILabel = {
        let label :UILabel = UILabel()
        label.text = "加载中"
        label.textColor = UIColor.black
        
        return label
    }()
    
    func setUp(){
        self.addSubview(activeView)
        self.addSubview(loadingLable)
        
        loadingLable.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        activeView.snp.makeConstraints { (make) in
            make.centerY.equalTo(loadingLable)
            make.right.equalTo(loadingLable.snp.left).offset(8)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
