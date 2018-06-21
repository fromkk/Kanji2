//
//  NSColor+Extensions.swift
//  Kanji2
//
//  Created by Kazuya Ueoka on 2018/06/21.
//  Copyright © 2018 fromKK. All rights reserved.
//

import AppKit

extension NSColor {
    convenience init?(rgbColor: String) {
        let color = rgbColor.replacingOccurrences(of: "#", with: "")
        var r: CGFloat?
        var g: CGFloat?
        var b: CGFloat?
        (0..<3).forEach { (i) in
            let code = color[color.index(color.startIndex, offsetBy: i * 2)..<color.index(color.startIndex, offsetBy: i * 2 + 2)]
            
            let hex = CGFloat(Int(code, radix: 16)!) / 255.0
            switch i {
            case 0:
                r = hex
            case 1:
                g = hex
            case 2:
                b = hex
            default:
                break
            }
        }
        
        guard let _r = r, let _g = g, let _b = b else {
            return nil
        }
        
        self.init(red: _r, green: _g, blue: _b, alpha: 1)
    }
    
    convenience init?(rgbaColor: String) {
        let color = rgbaColor.replacingOccurrences(of: "#", with: "")
        var r: CGFloat?
        var g: CGFloat?
        var b: CGFloat?
        var a: CGFloat?
        (0..<4).forEach { (i) in
            let code = color[color.index(color.startIndex, offsetBy: i * 2)..<color.index(color.startIndex, offsetBy: i * 2 + 2)]
            let hex = CGFloat(Int(code, radix: 16)!) / 255.0
            
            switch i {
            case 0:
                r = hex
            case 1:
                g = hex
            case 2:
                b = hex
            case 3:
                a = hex
            default:
                break
            }
        }
        
        guard let _r = r, let _g = g, let _b = b, let _a = a else {
            return nil
        }
        
        self.init(red: _r, green: _g, blue: _b, alpha: _a)
    }
}
