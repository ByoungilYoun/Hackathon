//
//  MyCollectionViewCell.swift
//  DominoPizza(CollectionViewInTableView)
//
//  Created by 윤병일 on 2020/07/05.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class MyCollectionViewCell : UICollectionViewCell {
  //MARK: - Properties
  
  static let identifier = "MyCollectionViewCell"
  
  private let imageView = UIImageView()
  private let nameLabel = UILabel()
  private let priceLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
    setConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - func configure()
  func configure(data : [String: Any]) {
    guard
      let name = data["품명"] as? String,
      let price = data["가격"] as? Int
      else {return}
    
    imageView.image = UIImage(named: name)
    nameLabel.text = name
    priceLabel.text = String(price) + "원"
    
  }
  
  
  //MARK: - UI
  
  private func setUI() {
    contentView.backgroundColor = .lightGray
    
    imageView.contentMode = .scaleAspectFit
    contentView.addSubview(imageView)
    
    nameLabel.tintColor = .white
    nameLabel.textAlignment = .center
    nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
    contentView.addSubview(nameLabel)
    
    priceLabel.tintColor = .white
    priceLabel.textAlignment = .center
    priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
    contentView.addSubview(priceLabel)
  }
  
  private func setConstraint() {
    [imageView, nameLabel, priceLabel].forEach {$0.translatesAutoresizingMaskIntoConstraints = false }
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
      
      nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
      priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      priceLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
    ])
    
  }
  
}
