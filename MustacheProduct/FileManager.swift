//
//  FileManager.swift
//  MustacheProduct
//
//  Created by mac on 2017/3/18.
//  Copyright © 2017年 myself. All rights reserved.
//

import Foundation

class myFilesManger  {
    func getHomePath() -> String {
        return Bundle.main.bundlePath;
    }
    
    func getMustacheFiles(_ path:String) -> [String]? {
        let fileMnager = FileManager.default;
        let names = try? fileMnager.contentsOfDirectory(atPath: path)
        return names
    }
}
