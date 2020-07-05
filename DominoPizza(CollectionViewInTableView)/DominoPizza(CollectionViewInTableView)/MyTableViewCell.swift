//
//  MyTableViewCell.swift
//  DominoPizza(CollectionViewInTableView)
//
//  Created by 윤병일 on 2020/07/05.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class MyTableViewCell : UITableViewCell {
  
  //MARK: - Properties
  
  static let identifier = "MyTableViewCell"
  
  private var categoryimageView = UIImageView()
  private var collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  private var productData = [[String : Any]]()
  
  //MARK: -  override init
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUI()
    setConstraint()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - func configure()
  func configure(data : [String : Any]) {
    guard
      let imageName = data["카테고리"] as? String,
      let productData = data["메뉴"] as? [[String: Any]]
    else { return }
    
    categoryimageView.image = UIImage(named: imageName)
    self.productData = productData
    collectionView.reloadData()
  }
  
  struct Standard {
    static let standard : CGFloat = 10
    static let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
  
  //MARK: - UI
  
  private func setUI() {
    categoryimageView.contentMode = .scaleToFill
    contentView.addSubview(categoryimageView)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
    contentView.addSubview(collectionView)
  }
  
  private func setConstraint() {
    [categoryimageView, collectionView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
    
    NSLayoutConstraint.activate([
      categoryimageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      categoryimageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      categoryimageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      categoryimageView.heightAnchor.constraint(equalToConstant: 64),
      
      collectionView.topAnchor.constraint(equalTo: categoryimageView.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 440)
      
    ])
    
  }
  
}

  //MARK: - UICollectionViewDataSource

extension MyTableViewCell : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    productData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
    cell.configure(data: productData[indexPath.item])
    return cell
  }
  
  
}

  //MARK: - UICollectionViewDelegateFlowLayout

extension MyTableViewCell : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    Standard.inset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Standard.standard
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width - Standard.inset.left - Standard.inset.right - Standard.standard
    let height = collectionView.frame.height - Standard.inset.top - Standard.inset.bottom
    return CGSize(width: width, height: height)
  }
}
