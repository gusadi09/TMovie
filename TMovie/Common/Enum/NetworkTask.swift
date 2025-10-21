//
//  NetworkTask.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

enum NetworkTask {
	case requestPlain
	case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}
