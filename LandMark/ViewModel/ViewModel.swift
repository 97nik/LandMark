//
//  ViewModel.swift
//  LandMark
//
//  Created by Никита on 15.07.2021.
//

import Foundation
import RealmSwift

class LandMarkRealm: Object {
	@objc dynamic var name = ""
	@objc dynamic var imageName = ""
	@objc dynamic var park = ""
	@objc dynamic var state  = ""
	@objc dynamic var descriptionPark = ""
	@objc dynamic var longitude = 0.0
	@objc dynamic var latitude  = 0.0
	@objc dynamic var isFavorite = true
}

class ViewModel: TableViewViewModelType {
	
	public typealias DataHandler = () -> Void
	private var selectedIndexPath: IndexPath?
	var networkService = NetworkService()
	var reloadHandler: DataHandler = { }
	var handler: DataHandler = { }
	let realm = try! Realm()
	var items: Results<LandMarkRealm> {
		return realm.objects(LandMarkRealm.self)
	}
	var landMarks = [LandMark]()
	
	func numberOfRows() -> Int {
		return landMarks.count
	}
	func parseJson() {
		self.networkService.performRequest { [weak self] result in
			DispatchQueue.global().async {
				DispatchQueue.main.async {
					switch result {
					case .success((let land)):
						self?.landMarks = land
						self?.saveData(land)
					case.failure:
						print("err")
					}
					self?.reloadHandler()
				}
			}
		}
	}
	
	func showLandMarks(){
		if realm.isEmpty {
			parseJson()
		} else {
			landMarks = []
			for item in items {
				DispatchQueue.main.async {
					let land = LandMark(name: item.name, state: item.state, isFavorite: item.isFavorite, park: item.park, coordinates: Coordinates(longitude: item.longitude, latitude: item.latitude), landMarkDescription: item.descriptionPark, imageName: item.imageName)
					self.reloadHandler()
					self.landMarks.append(land)
					
				}
			}
		}
	}
	
	private func saveData(_ landMarks:[LandMark]){
		var landMark = [LandMarkRealm]()
		for item in landMarks {
			let land = LandMarkRealm(value: ["\(item.name)", "\(item.imageName)", "\(item.park)", "\(item.state)","\(item.landMarkDescription)",item.coordinates.longitude,item.coordinates.latitude,item.isFavorite])
			landMark.append(land)
		}
		try! realm.write{
			realm.add(landMark)
		}
	}
	
	init(){
		showLandMarks()
	}
	
	func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
		let profile = landMarks[indexPath.row]
		print(TableViewCellViewModel(profile: profile))
		return TableViewCellViewModel(profile: profile)
	}
	
	func viewModelForSelectedRow() -> DetailViewModelType? {
		guard let selectedIndexPath = selectedIndexPath else { return nil }
		return DetailViewModel(profile: landMarks[selectedIndexPath.row])
	}
	
	func selectRow(atIndexPath indexPath: IndexPath) {
		self.selectedIndexPath = indexPath
	}
	
	func sortFavorite(){
		DispatchQueue.main.async {
			let positionOneNames = self.landMarks.compactMap{$0.isFavorite == true ? $0 : nil }
			self.landMarks = positionOneNames
			self.reloadHandler()
		}
	}
}
