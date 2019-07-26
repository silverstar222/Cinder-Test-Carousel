//
//  ReceipeModel.swift
//  ReceipeDemo
//
//  Created by Andy Castro on 26/07/19.
//  Copyright © 2019 Acquaint. All rights reserved.
//

import UIKit

class ReceipeModel: NSObject {

    
    var image:UIImage?
    var name:String?
    
    init(_ Receipename:String,ReceipeImage:UIImage){
        
        self.name = Receipename
        self.image = ReceipeImage
    }
}
