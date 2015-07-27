//
//  PhotoButton.swift
//  lovek12
//
//  Created by wangshiyu13 on 15/6/25.
//  Copyright © 2015年 manyi. All rights reserved.
//

import UIKit

class PhotoButton: UIButton {
    var contentImageView: UIImageView? {
        didSet {
            self.addSubview(contentImageView!)
            contentImageView!.frame = self.frame
            contentImageView!.contentMode = UIViewContentMode.ScaleAspectFill
            contentImageView?.clipsToBounds = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
