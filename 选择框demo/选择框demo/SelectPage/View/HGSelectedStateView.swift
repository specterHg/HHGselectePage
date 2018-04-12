//
//  AZJSelectedStateView.swift
//  AiZuJi
//
//  Created by Patrick on 2018/3/13.
//  Copyright © 2018年 Jason. All rights reserved.
//  选择页面

import UIKit

protocol HGSelectPageDelegate {
    /// 回传 选中的属性
    func hgSelectPage(_ selectedArray:Array<String>)
    
    /// 确认下单响应
    func  hgSelectCommitClick(_ sender :UIButton)
}

class HGSelectedStateView: UIView {
    
   public var delegate : HGSelectPageDelegate?
    
    @IBOutlet weak var shopView: UIView!        // 商品图片底层view
    @IBOutlet weak var shopImgV: UIImageView!   // 商品图片
    @IBOutlet weak var commitBtn: UIButton!     // 提交按钮
    @IBOutlet weak var myTableview: UITableView!
    
    private let cellName = "HGShopPropertyCell"
    
    var model:HGSelectModel!
    
    private  var btnTypeArr:NSMutableArray = [
        ["网络":true],    // 网络
        ["成色":true],    // 成色
        ["颜色":true],    // 颜色
        ["内存":true]     // 内存
    ]
    override func awakeFromNib() {
        self.myTableview.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        self.myTableview.delegate = self
        self.myTableview.dataSource = self
        shopView.layer.borderColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1).cgColor
        
    }
    
    // 关闭按钮
    @IBAction func closeBtnClick(_ sender: UIButton) {
        self.isHidden = true
        var arr : [String] = [String]()
        // 判断是否选中
        var myType : Bool!
        for index in 0...btnTypeArr.count-1 {
            let dic = btnTypeArr[index] as? [String:Bool]
            for dict in dic! {
                myType = dict.value
                if myType {
                    arr.append(dict.key)
                }
            }
        }
        
        delegate?.hgSelectPage(arr)
        
    }
    
    
    // 立即下单 按钮
    @IBAction func commitOderBtnClick (_ sender: UIButton) {
        
        delegate?.hgSelectCommitClick(sender)
    }
    
}

extension HGSelectedStateView {
    class func loadFromNib() -> HGSelectedStateView {
        return Bundle.main.loadNibNamed("HGSelectedStateView", owner: nil, options: nil)?[0] as! HGSelectedStateView
    }
}

// MARK - tableview
extension HGSelectedStateView:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelArr = [model?.network,model?.degree,model?.color,model?.mamory]
        let cel = tableView.dequeueReusableCell(withIdentifier: cellName) as!  HGShopPropertyCell
        cel.loadData(indexpath: indexPath)
        cel.rightTitleBtn.addTarget(self, action: #selector(celBtnClick(sender:)), for: .touchUpInside)
        cel.rightTitleBtn.setTitle( modelArr[indexPath.row], for: .normal)
        
        return cel
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v =  HGShopHeadView.loadFroNib()
        v.shopPriceLab.text = String.init(format: "%.2lf", (model?.shopPrice) ?? 0.00) 
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 82.5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  51.5
    }
    
    // cell btn
    @objc func celBtnClick (sender:UIButton) {
        
        let cel = sender.superview?.superview as!HGShopPropertyCell
        let indexpath = myTableview .indexPath(for: cel)
        
        if sender.isSelected {
            // 取消选中 - 点击效果
            touchTypeClick(cel, sender, false, indexpath!)
        } else {
            // 选中 - 点击效果
            touchTypeClick(cel, sender, true, indexpath!)
        }
        
        // 判断是否选中
        var myType = true
        for  index in 0...btnTypeArr.count-1 {
            
            let dic:[String:Bool] = btnTypeArr[index] as? [String:Bool] ?? ["":true]
            for dict in dic { myType = dict.value }
            
            if myType == true {
                commitBtn.isEnabled = true
                commitBtn.setBackgroundImage(UIImage.init(named: "hg_btn_default"), for: .normal)
            } else {
                commitBtn.isEnabled = false
                commitBtn.setBackgroundImage(UIImage.init(named: "hg_btn_gray"), for: .normal)
                break
            }
        }
        
    }
    
    // 点击效果
    private  func touchTypeClick (_ cel:HGShopPropertyCell,_ sender:UIButton ,_ myBool:Bool,_ indexpath:IndexPath){
        cel.selectColor(sender, myBool)
        sender.isSelected = myBool
        var dic = btnTypeArr[indexpath.row] as! [String:Bool]
        for key in dic { dic.updateValue(myBool, forKey: key.key) }
        btnTypeArr[indexpath.row] = dic
    }
}

/// 网络
extension HGSelectedStateView {
    func loadData (_ mymodel: HGSelectModel) {
        dicAddModelData(mymodel)
        guard mymodel.shopImgPath != nil else { return }
        //创建URL对象
        guard mymodel.shopImgPath.count != 0 else { return }
        print(mymodel.shopImgPath)
        let url = URL(string:(mymodel.shopImgPath)!)!
        //创建请求对象
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error.debugDescription)
            }else{
                //将图片数据赋予UIImage
                let img = UIImage(data:data!)
                DispatchQueue.main.async(execute: {
                    self.shopImgV.image = img
                })
            }
        }) as URLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
    }

    func dicAddModelData (_ mymodel: HGSelectModel) {
        btnTypeArr = [
            [mymodel.network :true],     // 网络
            [mymodel.degree :true],      // 成色
            [mymodel.color :true],       // 颜色
            [mymodel.mamory :true]       // 内存
        ]
        model = mymodel
        myTableview.reloadData()
    }
}

