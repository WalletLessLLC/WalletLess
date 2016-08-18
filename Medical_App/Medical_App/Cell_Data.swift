//
//  Cell_Data.swift
//  Medical_App
//
//  Created by Gregory Johnson on 8/18/16.
//  Copyright © 2016 Gregory Johnson. All rights reserved.
//

import UIKit

struct cellData {
    var title:String
    var image:UIImage
    var storyboardId:String
    
    init(title:String, image:UIImage, storyboardId:String) {
        self.title = title
        self.image = image
        self.storyboardId = storyboardId
    }
}

var cells = [cellData]()
var cellHeights:[CGFloat] = []