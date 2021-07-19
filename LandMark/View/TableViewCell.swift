//
//  TableViewCell.swift
//  LandMark
//
//  Created by Никита on 15.07.2021.
//

import Foundation
import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
	
	public static let identifier = "cell"
	private let customImage: UIImageView = UIImageView()
	
	weak var viewModel: TableViewCellViewModelType? {
		willSet(viewModel) {
			guard let viewModel = viewModel else { return }
			self.textLabel?.text = viewModel.name
			self.imageView?.image =  UIImage(named: viewModel.imageName)
			customImage.image = UIImage(systemName: viewModel.isFavorite)
			addSubview(customImage)
			
			customImage.snp.makeConstraints { (make) in
				make.width.height.equalTo(25)
				make.centerY.equalTo(contentView)
				make.right.equalToSuperview().multipliedBy (0.9)
			}
		}
	}
}
