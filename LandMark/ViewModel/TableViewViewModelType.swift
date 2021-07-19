//
//  TableViewViewModelType.swift
//  LandMark
//
//  Created by Никита on 15.07.2021.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {
	private var profile: LandMark
	
	var imageName: String {
		return profile.imageName
	}
	
	var isFavorite: String {
		if profile.isFavorite {
			return "star.fill"
		} else { return "" }
	}
	
	var name: String {
		return profile.name
	}
	
	init(profile: LandMark) {
		self.profile = profile
	}
}
