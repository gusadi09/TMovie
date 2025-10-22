//
//  TabContainerViewModel.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 22/10/25.
//

import Foundation

final class TabContainerViewModel: ObservableObject {
	@Published var selectedTab: TabPage = .search
}
