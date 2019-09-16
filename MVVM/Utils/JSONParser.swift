//
//  JSONParser.swift
//  MVVM
//
//  Created by rodrigo camparo on 9/15/19.
//  Copyright © 2019 rodrigo camparo. All rights reserved.
//

import Foundation

class JSONParser {
    
    static func decode<T: Decodable>(_ data: Data) -> T? {
        do {
            let decodable = try JSONDecoder().decode(T.self, from: data)
            return decodable
        } catch {
            return nil
        }
    }
}
