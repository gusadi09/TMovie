//
//  Encodable+toJSON.swift
//  Boxwise
//
//  Created by Ewide Dev 5 on 11/09/25.
//

import Foundation

extension Encodable {
    func toJSON() -> [String: Any] {
        let encoder = JSONEncoder()
        
        guard let data =  try? encoder.encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
              let json = dictionary as? [String: Any] else {
                    return [:]
                }
        return json
    }
    
    func toJSONData() -> Data {
        let encoder = JSONEncoder()
        
        guard let data =  try? encoder.encode(self) else {
            return Data()
        }
        
        return data
    }
}
