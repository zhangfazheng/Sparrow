//
//  UserInfoEditViewController.swift
//  Sparrow
//
//  Created by 张发政 on 2018/3/23.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit


class UserInfoEditViewController: UITableViewController {

    lazy var viewMode :UserInfoEditViewModel? = UserInfoEditViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    func setUpView() {
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.registerCellsClass(cellClasses: [CellClassType(classString: "ZFZValueTextCell")])
        tableView.register(ZFZValueTextCell.classForCoder(), forCellReuseIdentifier: "ZFZValueTextCell")
        
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewMode?.userEditArray?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueAndLoadContentReusableCellFromAdapter(adapter: (viewMode?.userEditArray![indexPath.row])!, indexPath: indexPath, controller: self)
        cell?.data?.valueSignal?.observe({ (value) in
            print(value.value ?? "")
        })
        
        return cell!
    }
}
