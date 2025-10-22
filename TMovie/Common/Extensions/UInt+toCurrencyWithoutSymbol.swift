//
//  Int+toCurrency.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 22/10/25.
//

import Foundation

extension UInt {
	func toCurrenyWithoutSymbol(locale: Locale = .current) -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.usesGroupingSeparator = true
		formatter.currencySymbol = ""
		formatter.locale = locale
	
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 0
		
		return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
	}
}
