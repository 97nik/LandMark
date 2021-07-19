//
//  LandMark.swift
//  LandMark
//
//  Created by Никита on 17.07.2021.
//
import Foundation

// MARK: - LandMark
struct LandMark: Codable {
	let name: String
	let state: String
	let isFavorite: Bool
	let park: String
	let coordinates: Coordinates
	let landMarkDescription, imageName: String

	enum CodingKeys: String, CodingKey {
		case name, state, isFavorite, park, coordinates
		case landMarkDescription = "description"
		case imageName
	}
}

// MARK: - Coordinates
struct Coordinates: Codable {
	let longitude, latitude: Double
}



