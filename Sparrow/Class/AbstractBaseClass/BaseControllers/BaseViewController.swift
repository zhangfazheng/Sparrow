//
//  BaseViewController.swift
//  Sparrow
//
//  Created by 张发政 on 2018/3/23.
//  Copyright © 2018年 zhangfazheng. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
import Argo

enum YPLodingKind {
    case AnimationLoadingType
    case TextLoadingType
    case AnimationAndTextType
}

enum NetWorkType {
    case NoNetWork
    case WiFi
    case WWAN
    case WWAN2G
    case WWAN3G
    case WWAN4G
    
}

enum VCErrorType {
    case NotShowError
    case ShowImg
    case ShowText
    case ShowImgAndText
    
}


class BaseViewController: UIViewController,UIGestureRecognizerDelegate,UITextViewDelegate,UITextFieldDelegate {
    
    var viewModel :BaseViewModel<Any>
    
    
    var width:CGFloat = 0
    var height:CGFloat = 0
    
    /**
     * loading的种类 (默认是Animation动画)
     */
    var tag:YPLodingKind = .AnimationLoadingType
    
    /**
     * ErrorType 判断无网显示类型
     */
    var errorTag:VCErrorType = .NotShowError
    
    /**
     * 判断网络情况
     */
    var netType:NetWorkType = .NoNetWork
    
    /**
     * 是否监测网络
     */
    var isListenNet :Bool = false
    
    /**
     * 自定义loading动画图片组
     */
    var AnimationImgs:Array<UIImage>?
    
    
    
    
// MARK: - 懒加载控件
    //标题
    lazy var titleView : UIView = {
        return self.navigationItem.titleView!
    }()
    
    //多标题
    lazy var doubleTitleView : DoubleTitleView = DoubleTitleView()
    
     // Loading title view
    lazy var loadingView :LoadingTitleView = LoadingTitleView(frame: CGRect(x:( UIScreen.main.bounds.width - 106)/2, y: 0, width: 106, height: 44))
    
    
    init(viewModel:BaseViewModel<Any>){
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        self.bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func bindViewModel() {
        
        self.viewModel.reactive.signal(forKeyPath: "title").observe { [weak self] (title) in
            self?.doubleTitleView.titleLabel.text = title.value as? String
            
        }
        
        self.viewModel.reactive.signal(forKeyPath: "subtitle").observe { [weak self] (subtitle) in
            self?.doubleTitleView.subtitleLabel.text = subtitle.value as? String
        }
        
        self.reactive.trigger(for: #selector(viewWillTransition(to:with:))).observe {[weak self] (event) in
            self?.doubleTitleView.titleLabel.text = self?.viewModel.title
            self?.doubleTitleView.subtitleLabel.text = self?.viewModel.subtitle
            
        }
        
        self.viewModel.reactive.signal(forKeyPath: "titleViewType").observe {[weak self] (event) in
            let titleViewType :TitleViewType = event.value as! TitleViewType
            
            switch (titleViewType) {
            case .TitleViewTypeDefault:
                self?.navigationItem.titleView = self?.titleView
            case .TitleViewTypeDoubleTitle:
                self?.navigationItem.titleView = self?.doubleTitleView;
            case .TitleViewTypeLoadingTitle:
                self?.navigationItem.titleView = self?.loadingView;
            }
            
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()

        // Do any additional setup after loading the view.
    }
    
    
    func setup() {
        self.width                                = UIScreen.main.bounds.width;
        self.height                               = UIScreen.main.bounds.height;
        self.view.backgroundColor                 = UIColor.white;
    }
    
    
    //在NavigationController堆栈内的UIViewController可以支持右滑手势，也就是不用点击右上角的返回按钮
    func useInteractivePopGestureRecognizer()  {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
    }
    
    

    
    /**
     *  If this controller is managed by an UINavigationController, you can use this method to pop.
     *
     *  @param animated Animated or not.
     */
    func popViewControllerAnimated(animated:Bool)  {
        self.navigationController?.popViewController(animated: animated)
    }
    
    /**
     *  If this controller is managed by an UINavigationController, you can use this method to pop to the rootViewController.
     *
     *  @param animated Animated or not.
     */
    func popToRootViewControllerAnimated(animated:Bool) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if DEBUG
        print("[➡️] Did entered to")
        #endif
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
