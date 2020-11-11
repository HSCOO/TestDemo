//
//  Date.swift
//  TestAPI
//
//  Created by 胡生才 on 2020/11/11.
//

import Foundation

struct DateHelper {
    func dateString() -> String{
        let now = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let string = dateFormatter.string(from: now)
        
        return string
    }
}


