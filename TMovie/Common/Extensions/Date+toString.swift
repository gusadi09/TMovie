//
//  Date+toString.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

extension Date {
	func toString(with format: DateFormat) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format.rawValue
		formatter.locale = Locale(identifier: "en_US_POSIX")
		
		return formatter.string(from: self)
	}
}
