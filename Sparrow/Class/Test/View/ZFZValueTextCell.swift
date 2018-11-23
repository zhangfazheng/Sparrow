//
//  ZFZValueTextCell.swift
//  Sparrow
//
//  Created by 张发政 on 2018/3/23.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit
import SnapKit

class ZFZValueTextCell: BaseCell<ZFZEditTileCellModel> {
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
    
    override func setupCell() {
        self.accessoryType = .disclosureIndicator
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(valueLabel)
        self.contentView.addSubview(uitsLable)
        
        let superview = self.contentView
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(superview)
            make.left.equalTo(superview).offset(18)
            make.width.equalTo(80)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(superview).offset(5);
            make.left.equalTo(titleLabel.snp.right).offset(44);
            make.bottom.equalTo(superview).offset(-5);
            make.height.greaterThanOrEqualTo(34).priority(.high);
        }
        
        uitsLable.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel);
            make.height.equalTo(titleLabel);
            make.width.equalTo(20);
            make.left.equalTo(valueLabel.snp.right).offset(8);
            make.right.equalTo(superview.snp.right).offset(-16);
        }
        
    }
    
    override func loadContent() {
        if let item = data{
            titleLabel.text = item.tilleString
            valueLabel.text = item.valueString
            
            if let unitStr: String = item.units{
                uitsLable.isHidden = false
                uitsLable.text = unitStr
            }else{
                uitsLable.isHidden = true
            }
            
            valueLabel.keyboardType = item.keyBordType!
            
            item.valueSignal = valueLabel.reactive.controlEvents(UIControlEvents.editingDidEnd).map({ (textField:UITextField) -> String in
                return textField.text ?? ""
            })
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    lazy var titleLabel:UILabel = {
        let lable:UILabel = UILabel()
        return lable
        
    }()
    lazy var valueLabel:UITextField = {
        let lable:UITextField = UITextField()
        lable.textAlignment = NSTextAlignment.right
        lable.textColor = UIColor.gray
        return lable
        
    }()
    lazy var uitsLable:UILabel = {
        let lable:UILabel = UILabel()
        lable.textAlignment = NSTextAlignment.right
        lable.textColor = UIColor.gray
        lable.isHidden = true
        
        return lable
    }()
    
}
