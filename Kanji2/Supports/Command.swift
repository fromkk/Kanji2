//
//  Command.swift
//  KanjiCore
//
//  Created by Kazuya Ueoka on 2018/06/20.
//  Copyright © 2018 fromKK. All rights reserved.
//

import Foundation

/// execute shell command
public class Command {
    private static let which: String = "/usr/bin/which"
    
    /// perform shell command
    ///
    /// - Parameters:
    ///   - command: String
    ///   - arguments: [String]?
    /// - Returns: String?
    public static func run(_ command: String, arguments: [String]? = nil) -> String? {
        let path: String
        if command.hasPrefix("/") {
            path = command
        } else {
            // get fullpath from which
            guard let command = self.run(self.which, arguments: [command]) else {
                return nil
            }
            path = command
        }
        
        let process = Process()
        process.launchPath = path
        process.arguments = arguments ?? []
        
        let pipe = Pipe()
        process.standardOutput = pipe
        process.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
