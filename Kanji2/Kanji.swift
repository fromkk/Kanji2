//
//  Kanji.swift
//  KanjiCore
//
//  Created by Kazuya Ueoka on 2018/06/20.
//  Copyright © 2018 fromKK. All rights reserved.
//

import AppKit
import CoreGraphics

public class Kanji {
    
    public static func setup(with path: String) throws {
        let url = URL(fileURLWithPath: path)
        let filename = url.lastPathComponent
        let directory = path.replacingOccurrences(of: filename, with: "")
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: directory) {
            try fileManager.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    public static func image(_ character: String, font: String, size: CGSize) -> NSImage? {
        
        let width: Int = Int(size.width)
        let height: Int = Int(size.height)
        let bitsPerComponent: Int = 8
        let bytesPerRow: Int = Int(4) * width
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo: CGBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        guard let context: CGContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            print("context get failed")
            return nil
        }
        
        context.setFillColor(NSColor.white.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        
        guard let imageRef = context.makeImage() else {
            print("imageRef get failed")
            return nil
        }
        
        let image = NSImage(cgImage: imageRef, size: size as NSSize)
        image.lockFocus()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: NSFont(name: font, size: size.height)!,
            NSAttributedStringKey.paragraphStyle: paragraphStyle
        ]
        
        let textSize = (character as NSString).boundingRect(with: size, options: [], attributes: attributes)
        
        (character as NSString).draw(at: CGPoint(x: (size.width - textSize.width) / 2.0, y: (size.height - textSize.height) / 2.0), withAttributes: attributes)
        
        image.unlockFocus()
        
        return image
    }
    
}
