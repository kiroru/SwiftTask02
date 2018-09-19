//
//  Item.swift
//  RealmSample
//
//  Created by ueda on 2018/08/31.
//  Copyright © 2018年 kohei.ueda. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var id : Int = 0
    @objc dynamic var title : String = ""
    @objc dynamic var explanation : String = ""
    
}
