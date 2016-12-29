//
//  LList.swift
//  DueList
//
//  Created by 张瑞麟 on 2016/12/28.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import Foundation

class LList{
    //    var dueList:Array<DueElement> = Array()
    var dueList = [DueElement]()
    var size = 0;
    
    init(element: DueElement){
        dueList.insert(element, at:0)
        size+=1;
    }
    
    func add(element:DueElement){
        var insertEnd = true
        for i in 0...dueList.count-1{
            if(element.timeLeft!<dueList[i].timeLeft!){
                dueList.insert(element, at: i)
                insertEnd = false
            }
        }
        if(insertEnd){
            dueList.append(element)
        }
        size+=1;
    }
    
    
}
