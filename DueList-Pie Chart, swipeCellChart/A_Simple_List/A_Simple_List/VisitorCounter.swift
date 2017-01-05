//
//  VisitorCounter.swift
//  A_Simple_List
//
//  Created by 张瑞麟 on 2017/1/4.
//  Copyright © 2017年 Xintong Wu. All rights reserved.
//

import Foundation
import RealmSwift

class VisitorCount : Object{
    dynamic var date: Date = Date()
    dynamic var count: Int = Int(0)
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
