//
//  main.swift
//  Kanji2
//
//  Created by Kazuya Ueoka on 2018/06/20.
//  Copyright © 2018 fromKK. All rights reserved.
//

import Foundation
import AppKit
import CoreGraphics

func showHelp() {
    print("""
kanji --character <character> --width <width> --height <height> --font <font> --output <output>
character | set character for create image
width     | set image width
height    | set image height
font      | set font name
output    | set image output path
""")
}

let arguments = Arguments().parse()

guard let character = arguments["character"], character.count == 1 else {
    showHelp()
    exit(1)
}

let font = arguments["font"] ?? "HiraKakuProN-W3"

let fontManager = NSFontManager()
guard fontManager.availableFonts.contains(font) else {
    print("font \(font) not available")
    exit(1)
}

guard let outputPath = arguments["output"] else {
    print("output path not found")
    showHelp()
    exit(1)
}

do {
    try Kanji.setup(with: outputPath)
} catch {
    print("setup failed")
    exit(1)
}

let width: Int = Int(arguments["width"] ?? "300")!
let height: Int = Int(arguments["height"] ?? "300")!

guard let image = Kanji.image(character, font: font, size: CGSize(width: CGFloat(width), height: CGFloat(height))) else {
    print("image make failed")
    exit(1)
}

guard let data = image.tiffRepresentation else {
    print("data get failed")
    exit(1)
}

do {
    try data.write(to: URL(fileURLWithPath: outputPath))
} catch {
    print("data write failed", error)
    exit(1)
}

print("Done!", outputPath)
