//
//  DetailViewController.swift
//  LandMark
//
//  Created by Никита on 15.07.2021.
//

import Foundation
import UIKit
import SnapKit
import MapKit

class DetailViewController: UIViewController {
	lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
	
	lazy var scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.frame = view.bounds
		scroll.contentSize = contentViewSize
		scroll.autoresizingMask = .flexibleWidth
		scroll.showsHorizontalScrollIndicator = true
		scroll.bounces = true
		return scroll
	}()
	
	lazy var containerView: UIView = {
		let view = UIView()
		view.frame.size = contentViewSize
		return view
	}()
	
	lazy var viewMap : MKMapView = {
		let viewMap = MKMapView()
		return viewMap
	}()
	
	lazy var viewImage : UIImageView = {
		let viewImage =  UIImageView()
		viewImage.bounds.size = CGSize(width: 200, height: 200)
		viewImage.contentMode = .scaleAspectFit
		viewImage.layer.cornerRadius = viewImage.bounds.height/2
		viewImage.clipsToBounds = true
		viewImage.layer.borderWidth = 3.0
		viewImage.layer.borderColor = UIColor.white.cgColor
		viewImage.layer.shadowColor = UIColor.black.cgColor
		viewImage.layer.shadowPath = UIBezierPath(roundedRect: viewImage.bounds, cornerRadius:viewImage.layer.cornerRadius).cgPath
		viewImage.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
		viewImage.layer.shadowOpacity = 0.5
		viewImage.layer.shadowRadius = 1.0
		return viewImage
	}()
	
	lazy var viewImages : UIView = {
		let viewImage =  UIView()
		viewImage.bounds.size = CGSize(width: 200, height: 200)
		viewImage.layer.shadowColor = UIColor.black.cgColor
		viewImage.layer.shadowOffset = CGSize(width: 10, height: 10)
		viewImage.layer.shadowOpacity = 0.7
		viewImage.layer.shadowRadius = 7.0
		viewImage.layer.masksToBounds = false
		return viewImage
	}()
	
	lazy var textLabel : UILabel = {
		var textLabel = UILabel()
		textLabel.font = textLabel.font.withSize(24)
		
		return textLabel
	}()
	
	lazy var imageStar : UIImageView = {
		var imageStar = UIImageView()
		return imageStar
	}()
	
	lazy var textPark : UILabel = {
		var textPark = UILabel()
		textPark.font = textPark.font.withSize(14)
		textPark.alpha = 0.5
		return textPark
	}()
	
	lazy var textState : UILabel = {
		var textState = UILabel()
		textState.font = textState.font.withSize(14)
		textState.alpha = 0.5
		textState.text = "Alaska"
		return textState
	}()
	
	lazy var line : UILabel = {
		var textState = UILabel()
		textState.bounds.size = CGSize(width: 200, height: 100)
		textState.backgroundColor = .black
		textState.alpha = 0.2
		return textState
	}()
	
	lazy var textAboutPark : UILabel  = {
		var textAboutPark = UILabel()
		textAboutPark.font = textAboutPark.font.withSize(20)
		return  textAboutPark
	}()
	
	lazy var textAboutParkDescription : UILabel  = {
		var textAboutPark = UILabel()
		textAboutPark.font = textAboutPark.font?.withSize(17)
		textAboutPark.frame.size = contentViewSize
		textAboutPark.numberOfLines = 0
		return textAboutPark
	}()
	
	var viewModel: DetailViewModelType?
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		fillDate()
		configProgressView()
	}
	
	private func fillDate() {
		guard let viewModel = viewModel else { return }
		self.navigationItem.title = viewModel.name
		self.navigationController?.navigationBar.prefersLargeTitles = false
		self.textLabel.text = viewModel.name
		self.imageStar.image = UIImage(systemName: viewModel.isFavorite)
		self.viewImage.image = UIImage(named: viewModel.imageName)
		self.textPark.text = viewModel.park
		self.textState.text = viewModel.state
		self.textAboutPark.text = viewModel.aboutPark
		self.textAboutParkDescription.text = viewModel.description
		
		let cordinate  = CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude)
		self.viewMap.setRegion(MKCoordinateRegion(center: cordinate, span:MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2) ), animated: false)
	}
	
	private func configProgressView() {
		self.view.backgroundColor = .white
		self.view.addSubview(scrollView)
		scrollView.addSubview(containerView)
		containerView.addSubview(viewMap)
		containerView.addSubview(viewImages)
		viewImages.addSubview(viewImage)
		containerView.addSubview(textLabel)
		containerView.addSubview(imageStar)
		containerView.addSubview(textPark)
		containerView.addSubview(textState)
		containerView.addSubview(line)
		containerView.addSubview(textAboutPark)
		containerView.addSubview(textAboutParkDescription)
		makingConstraint()
	}
	
	private func makingConstraint() {
		self.scrollView.snp.makeConstraints { (make) in
			make.top.right.bottom.left.equalToSuperview()
		}
		
		self.viewMap.snp.makeConstraints { (make) in
			make.height.equalTo(self.view).multipliedBy(0.33)
			make.width.equalTo(self.view).multipliedBy (1)
			make.top.equalToSuperview()
		}
		
		self.viewImage.snp.makeConstraints { (make) in
			make.height.width.equalTo(200)
			make.centerX.equalTo(self.view)
			make.top.equalTo(viewMap.snp_bottomMargin).offset(-self.view.bounds.width/4)
		}
		
		self.viewImages.snp.makeConstraints { (make) in
			make.height.width.equalTo(200)
			make.centerX.equalTo(self.viewImage)
			make.centerY.equalTo(self.viewImage)
		}
		
		self.textLabel.snp.makeConstraints { (make) in
			make.top.equalTo(viewImage.snp_bottomMargin).offset(20)
			make.left.equalToSuperview().inset(16)
			make.right.equalTo(imageStar.snp_leftMargin).inset(-16)
		}
		
		self.imageStar.snp.makeConstraints { (make) in
			make.height.width.equalTo(20)
			make.top.equalTo(viewImage.snp_bottomMargin).offset(25)
			make.left.equalTo(textLabel.snp_rightMargin).inset(16)
		}
		
		self.textPark.snp.makeConstraints { (make) in
			make.top.equalTo(textLabel.snp_bottomMargin).offset(8)
			make.left.equalToSuperview().inset(16)
			make.right.equalTo(textState.snp_leftMargin).offset(4)
		}
		
		self.textState.snp.makeConstraints { (make) in
			make.top.equalTo(textLabel.snp_bottomMargin).offset(8)
			make.left.equalTo(textPark.snp_rightMargin).offset(4)
			make.right.equalToSuperview().inset(16)
		}
		
		self.line.snp.makeConstraints { (make) in
			make.width.equalTo(300)
			make.height.equalTo(1)
			make.top.equalTo(textPark.snp_bottomMargin).offset(16)
			make.right.left.equalToSuperview().inset(16)
		}
		
		self.textAboutPark.snp.makeConstraints { (make) in
			make.width.equalTo(300)
			make.top.equalTo(line.snp_bottomMargin).offset(16)
			make.right.left.equalToSuperview().inset(16)
		}
		self.textAboutParkDescription.snp.makeConstraints { (make) in
			make.width.equalTo(300)
			make.top.equalTo(textAboutPark.snp_bottomMargin).offset(8)
			make.right.left.equalToSuperview().inset(16)
		}
	}
}
