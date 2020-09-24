//
//  EncryptedText.swift
//  decrypt
//
//  Created by Guilherme Rangel on 23/09/20.


import Foundation

    public func readFile(fileName: String) -> String {
        let url = Bundle.main.url(forResource: fileName, withExtension: "txt")!
        let text = try! String(contentsOf: url, encoding: .utf8)
        return text
    }
    
    

