//
//  String+OrEmpty.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 13/08/25.
//

import Foundation

extension Optional where Wrapped == String {
    func orEmpty() -> String {
        return self ?? ""
    }
}
