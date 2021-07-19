//
//  APIService.swift
//  LandMark
//
//  Created by Никита on 17.07.2021.
//

import Foundation
import UIKit

enum ApiError : Error {
	case noData
}
class NetworkService {
	
	func performRequest (completion: @escaping (Result<([LandMark]), Error>) -> Void) {
		if let path = Bundle.main.path(forResource: "landmarkData", ofType: "json"){
			let data = try! Data(contentsOf: URL(fileURLWithPath: path))
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			do {
				let landMarks = try decoder.decode([LandMark].self, from: data)
				completion(.success(landMarks))
			} catch let error as NSError {
				completion(.failure(error))
				print(error.localizedDescription)
			}
		}
	}
}
