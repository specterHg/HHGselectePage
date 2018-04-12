//
//  AZJShopPropertyCell.swift
//  AiZuJi
//
//  Created by Patrick on 2018/3/13.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class HGShopPropertyCell: UITableViewCell {
    
    @IBOutlet weak var leftTitleLab: UILabel!
    @IBOutlet weak var rightTitleBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectColor(rightTitleBtn,true)
    }
    
    func loadData (indexpath:IndexPath) {
        let leftData = ["网络","成色","颜色","内存"]
        leftTitleLab.text = leftData[indexpath.row]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
       
    }
    
    func selectColor (_ sender:UIButton, _ isRed:Bool){
        if isRed {
            sender.layer.borderColor = UIColor.init(red: 232/255.0, green: 51/255.0, blue: 35/255.0, alpha: 1).cgColor
        } else {
            sender.layer.borderColor = UIColor.init(red: 206/255.0, green: 206/255.0, blue: 206/255.0, alpha: 1).cgColor
        }
        
        sender.layer.borderWidth = 1
    }
    
}
