//
//  TableViewCellViewModelType.swift
//  LandMark
//
//  Created by Никита on 15.07.2021.
//

import Foundation

protocol TableViewCellViewModelType: class {
	var name: String { get }
	var imageName: String { get }
	var isFavorite: String { get }
}
