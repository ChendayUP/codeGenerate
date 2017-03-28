//
//  ConsoleIO.swift
//  clidemo
//
//  Created by mac on 2017/2/27.
//  Copyright © 2017年 myself. All rights reserved.
//

import Foundation

class ConsoleIO {
    func getInput() -> String {
        
        // 1
        let keyboard = FileHandle.standardInput
        
        // 2
        let inputData = keyboard.availableData
        
        // 3
        let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        
        // 4
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
}
