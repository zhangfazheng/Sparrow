//
//  DoubleTitleView.swift
//  Sparrow
//
//  Created by 张发政 on 2018/5/23.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit
import Foundation

class DoubleTitleView: UIView {

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var titleLabelFrame:CGRect = self.titleLabel.frame
        titleLabelFrame.size.width =  ZFZTool.Min(a: self.titleLabel.bounds.width, b: self.bounds.width)
        
        titleLabelFrame.origin.x = self.bounds.width / 2 - self.titleLabel.bounds.width / 2;
        titleLabelFrame.origin.y = 4;
        self.titleLabel.frame = titleLabelFrame;
        
        var subtitleLabelFrame :CGRect = self.subtitleLabel.frame;
        subtitleLabelFrame.size.width =  ZFZTool.Min(a: self.subtitleLabel.bounds.width, b: self.bounds.width);
        subtitleLabelFrame.origin.x = self.bounds.width / 2 - self.subtitleLabel.bounds.width / 2;
        subtitleLabelFrame.origin.y = self.bounds.height - 4 - self.subtitleLabel.bounds.height;
        self.subtitleLabel.frame = subtitleLabelFrame;
    }
    
    
    //MARK:懒加载
    lazy var titleLabel : UILabel = {
        var view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 17)
        view.textAlignment = NSTextAlignment.center
        view.textColor = UIColor.white
        
        
        return view
    }()

    
    lazy var subtitleLabel :UILabel = {
        var subtitleLabel = UILabel()
        subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        subtitleLabel.textAlignment = NSTextAlignment.center;
        subtitleLabel.textColor = UIColor.white
        return subtitleLabel
    }()
    
}
