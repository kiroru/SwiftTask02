//
//  Item.swift
//  SwiftTask02
//
//  Created by sak on 2018/09/19.
//  Copyright © 2018年 kohei.ueda. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var title : String = ""
    @objc dynamic var explanation : String = ""
}
