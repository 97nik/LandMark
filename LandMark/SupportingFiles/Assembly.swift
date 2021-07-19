//
//  Assembly.swift
//  LandMark
//
//  Created by Никита on 15.07.2021.
//
//
import Foundation
import UIKit

class Assembly {
	static func makeModuleVC() -> UINavigationController {
		let viewModel = ViewModel()
		let vc = TableViewController(viewModel: viewModel)
		let nc = UINavigationController(rootViewController: vc)
		return nc
	}
}
