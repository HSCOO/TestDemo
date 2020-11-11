//
//  SaveHelper.swift
//  TestAPI
//
//  Created by 胡生才 on 2020/11/11.
//

import Foundation

enum SaveJsonKey: String {
    case time = "time"
    case value = "value"
}

enum SaveKey:String {
    case history = "history"
}

struct SaveHelper {
    func set(value: String, key: String) {
        let dateString = DateHelper().dateString()
        let json = [
            SaveJsonKey.time.rawValue : dateString,
            SaveJsonKey.value.rawValue : value
        ]
        var array = Array<Any>()
        if let saveArray = get(key: key) {
            array = saveArray
        }
        array.append(json)

        UserDefaults.standard.set(array, forKey: key)
    }
    
    func get(key: String) -> Array<Any>? {
        return UserDefaults.standard.array(forKey: key)
    }
    
    func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
