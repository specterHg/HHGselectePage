//
//  AZJShopHeadView.swift
//  AiZuJi
//
//  Created by Patrick on 2018/3/13.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit

class HGShopHeadView: UIView {

    @IBOutlet weak var shopPriceLab: UILabel!

}

extension HGShopHeadView{
    class func loadFroNib() -> HGShopHeadView {
        return Bundle.main.loadNibNamed("HGShopHeadView", owner: nil, options: nil)?[0] as!HGShopHeadView
    }
}
