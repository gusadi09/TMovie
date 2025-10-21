//
//  NetworkMonitor.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 21/10/25.
//

import Foundation
import Network
import Combine

final class NetworkMonitor: ObservableObject {
	static let shared = NetworkMonitor()
	
	private let monitor: NWPathMonitor
	private let queue = DispatchQueue(label: "NetworkMonitor")
	
	@Published private(set) var isConnected: Bool = false
	@Published private(set) var availableInterfaceTypes: [NWInterface.InterfaceType] = []
	
	private init() {
		monitor = NWPathMonitor()
		monitor.pathUpdateHandler = { [weak self] path in
			DispatchQueue.main.async {
				self?.isConnected = path.status == .satisfied
				var types: [NWInterface.InterfaceType] = []
				if path.usesInterfaceType(.wifi) { types.append(.wifi) }
				if path.usesInterfaceType(.cellular) { types.append(.cellular) }
				if path.usesInterfaceType(.wiredEthernet) { types.append(.wiredEthernet) }
				if path.usesInterfaceType(.other) { types.append(.other) }
				self?.availableInterfaceTypes = types
			}
		}
		monitor.start(queue: queue)
	}
	
	deinit {
		monitor.cancel()
	}
}
