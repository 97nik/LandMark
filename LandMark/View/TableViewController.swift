//
//  TableViewController.swift
//  LandMark
//
//  Created by Никита on 15.07.2021.
//

import Foundation
import UIKit
import SnapKit

class TableViewController: UITableViewController {
	
	internal var didActionButtonTapTableHandler: (() -> (Void))?
	
	var viewModel = ViewModel()
	
	var viewFavorite : UIView = {
		var favorite = UIView()
		return favorite
	}()
	
	var favorite : UILabel = {
		var favorite = UILabel()
		favorite.text = "Favorites only"
		return favorite
	}()
	
	var switchFavorite: UISwitch = {
		var switchFavorite = UISwitch()
		switchFavorite.isOn = false
		switchFavorite.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
		return switchFavorite
	}()
	
	@objc func switchValueDidChange(_ sender: UISwitch!) {
		if (sender.isOn) {
			self.viewModel.sortFavorite()
		}
		else {
			self.viewModel.showLandMarks()
		}
	}
	
	init(viewModel: TableViewViewModelType) {
		self.viewModel = ViewModel()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewModel.reloadHandler = {
			self.tableView.reloadData()
		}
		configfavorite()
	//	self.configureView()
	}
	
	private func configfavorite() {
		self.tableView.contentInset = UIEdgeInsets(top: 58, left: 0, bottom: 0, right: 0)
		self.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
		self.navigationItem.title = "Landmarks"
		
		self.view.addSubview(viewFavorite)
		viewFavorite.addSubview(favorite)
		viewFavorite.addSubview(switchFavorite)
		
		self.viewFavorite.snp.makeConstraints { (make) in
			make.width.equalTo(350)
			make.height.equalTo(50)
			make.top.equalTo(-50)
			make.left.right.equalToSuperview().inset(16)
			make.right.equalTo(self.view).inset(20)
		}
		self.favorite.snp.makeConstraints { (make) in
			make.centerY.equalTo(viewFavorite)
			make.left.equalToSuperview()
		}
		self.switchFavorite.snp.makeConstraints { (make) in
			make.centerY.equalTo(viewFavorite)
			make.right.equalTo(viewFavorite).inset(0)
		}
	}
	
	// MARK: - Table view data source
	internal override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50.0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows() 
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard  let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
		cell.accessoryType = .disclosureIndicator
		cell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.selectRow(atIndexPath: indexPath)
		let vcD = DetailViewController()
		vcD.viewModel = viewModel.viewModelForSelectedRow()
		self.navigationController?.pushViewController(vcD, animated: true)
	}
}
