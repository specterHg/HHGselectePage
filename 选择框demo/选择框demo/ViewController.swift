//
//  ViewController.swift
//  选择框demo
//
//  Created by Patrick on 2018/4/11.
//  Copyright © 2018年 specter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var selectView = HGSelectedStateView.loadFromNib()
    /// 选择页选中的数据
    var selectArr = [String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnClick(_ sender: UIButton) {
        
        selectView.isHidden = false
        let dic = [
            "color" :"亮黑",
            "degree" : "99新",
            "mamory" : "64G",
            "network" : "全网通",
            "shopImgPath" : "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg" ,
            "shopPrice" : 8888.00
            ] as [String : Any]
        selectPage(dic)
    }
}


extension ViewController:HGSelectPageDelegate {
    func hgSelectPage(_ selectedArray: Array<String>) {
        
        // refresh self view
    }
    
    func hgSelectCommitClick(_ sender: UIButton) {

        // go to other viewcontroller
    }
    
    func selectPage(_ dic :[String:Any]) {
        selectView.delegate = self
        selectView.loadData(HGSelectModel.init(fromDictionary: dic))
        selectView.frame = self.view.frame
        self.view.addSubview(selectView)
    }
}
