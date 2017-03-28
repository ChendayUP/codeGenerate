//
//  main.swift
//  MustacheProduct
//
//  Created by mac on 2017/3/10.
//  Copyright © 2017年 myself. All rights reserved.
//

import Foundation

let manager = myFilesManger()
let home = manager.getHomePath();

let jsonpath = "/Users/mac/Documents/MyWork/macOS/response.json"

let typeName = [
    "__NSCFString" : "NSString",
    "__NSCFNumber" : "NSInteger",
    "__NSDictionaryM" : "",
]

let typestrong = [
    "__NSCFString" : true,
    "__NSCFNumber" : false
]

let UItype = [
    "__NSCFString" : "Label"
]


var userList:NSMutableArray?
let url = URL(fileURLWithPath: jsonpath)
var getArray : Array<Any> = Array()
do{
    let data = try Data(contentsOf: url)
    let json:Any = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers)
    let jsonDic = json as! Dictionary<String,Any>
    
    for (key,value) in jsonDic {
        if value is NSNull {
            getArray.append(["type":"String",
                             "typename":key,
                             "strong":true,
                             "image": false,
                             "uitype": "Label"])
        } else {
            let type = String(describing: type(of: value))
            let isImage:Bool
            if let v = value as? String {
                isImage = v.hasSuffix(".png") || v.hasSuffix(".jpg")
            } else {
                isImage = false
            }
            
            getArray.append(["type":typeName[type] ?? "String",
                             "typename":key,
                             "strong":typestrong[type] ?? true,
                             "image": isImage,
                             "uitype": isImage ? "ImageView" :"Label"])
        }

    }
    
} catch {
    
}

print("请输入model名称:")
let consoleIO = ConsoleIO()
let name = consoleIO.getInput()
//let name = "login"

let dic:[String:Any] = [
    "properties" : getArray,
    "name" : name
]

if let files = manager.getMustacheFiles("\(home)/mustache") {
    for var mPath in files {
        var template = try Template(path:"\(home)/mustache/\(mPath)")
        // The rendering: "Hello Arthur..."
        var rendering = try template.render(dic)
        
        // 处理后缀名称
        mPath = mPath.replacingOccurrences(of: "_h.mustache", with: ".h")
        mPath = mPath.replacingOccurrences(of: "_m.mustache", with: ".m")
        try rendering.write(toFile: "\(home)/models/\(name)\(mPath)", atomically: true, encoding: .utf8)
    }
}
