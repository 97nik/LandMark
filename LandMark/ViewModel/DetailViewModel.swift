//
//  DetailViewModel.swift
//  LandMark
//
//  Created by Никита on 15.07.2021.
//

import Foundation

protocol DetailViewModelType {
	var aboutPark: String { get }
	var name: String { get }
	var imageName: String { get }
	var park: String { get }
	var state: String { get }
	var description: String { get }
	var longitude: Double { get }
	var latitude: Double { get }
	var isFavorite: String { get }
}


class DetailViewModel: DetailViewModelType {
	
	private var profile: LandMark
	
	var name: String {
		return String(profile.name)
	}
	
	var aboutPark: String {
		return String(describing: "About \(profile.name)")
	}
	var imageName: String {
		return String(profile.imageName)
	}
	var park: String {
		return String(profile.park)
	}
	var state: String {
		return String(profile.state)
	}
	var description: String {
		return String(profile.landMarkDescription)
	}
	var longitude: Double {
		return (profile.coordinates.longitude)
	}
	var latitude: Double {
		return (profile.coordinates.latitude)
	}
	
	var isFavorite: String{
		if profile.isFavorite {
			return String("star.fill")
		}
		return String("star")
	}
	
	init(profile: LandMark) {
		self.profile = profile
	}
}
