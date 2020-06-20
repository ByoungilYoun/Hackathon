//
//  DetailViewController.swift
//  DominoPizza
//
//  Created by 윤병일 on 2020/06/20.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
  var productName = ""
  
  private let shared = Singleton.standard
  
  private let imageView = UIImageView()
  private let containerView = UIView()
  private let minusButton = UIButton()
  private let plusButton = UIButton()
  private let displayLabel = UILabel()
  
  private var selectCount : Int = 0 {
    didSet {
      displayLabel.text = "\(selectCount) 개"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigation()
    setUI()
    setConstraint()
    
  }
  
  
  //화면이 떠야하는 걸 인지했을 때 Count 값을 바꿔줄때
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let value = shared.wishListDict[productName] {
      selectCount = value
    } else {
      selectCount = 0
    }
  }
  
  private func setNavigation() {
    navigationItem.title = productName
  }
  
  private func setUI() {
    view.backgroundColor = .white
    
    imageView.image = UIImage(named: productName)
    imageView.contentMode = .scaleToFill
    view.addSubview(imageView)
    
    view.addSubview(containerView)
    
    minusButton.setTitle("-", for: .normal)
    minusButton.setTitleColor(.black, for: .normal)
    minusButton.layer.borderWidth = 3
    minusButton.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    minusButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    containerView.addSubview(minusButton)
    
    displayLabel.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    displayLabel.text = "\(selectCount) 개"
    displayLabel.textAlignment = .center
    displayLabel.textColor = .white
    containerView.addSubview(displayLabel)
    
    plusButton.setTitle("+", for: .normal)
    plusButton.setTitleColor(.black, for: .normal)
    plusButton.layer.borderWidth = 3
    plusButton.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    plusButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    containerView.addSubview(plusButton)
    
  }
  
  private struct Standard {
    static let space : CGFloat = 48
  }
  
  private func setConstraint() {
      let guide = view.safeAreaLayoutGuide
      
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: Standard.space).isActive = true
      imageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
      imageView.widthAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
      imageView.heightAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
      
      containerView.translatesAutoresizingMaskIntoConstraints = false
      containerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Standard.space).isActive = true
      containerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Standard.space).isActive = true
      containerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -Standard.space).isActive = true
      containerView.heightAnchor.constraint(equalToConstant: Standard.space).isActive = true
      
      minusButton.translatesAutoresizingMaskIntoConstraints = false
      minusButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
      minusButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
      minusButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
      minusButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.2).isActive = true
      
      displayLabel.translatesAutoresizingMaskIntoConstraints = false
      displayLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
      displayLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor).isActive = true
      displayLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
      displayLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6).isActive = true
      
      plusButton.translatesAutoresizingMaskIntoConstraints = false
      plusButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
      plusButton.leadingAnchor.constraint(equalTo: displayLabel.trailingAnchor).isActive = true
      plusButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
      plusButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
      plusButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.2).isActive = true
    }
  
  @objc private func buttonAction (_ sender : UIButton) {
    switch sender {
    case minusButton :
      guard selectCount > 0 else {return}
      selectCount -= 1
    case plusButton :
      selectCount += 1
    default :
      break
    }
    
    guard selectCount != 0 else {
      shared.wishListDict[productName] = nil
      return
    }
    shared.wishListDict[productName] = selectCount
  }
  }

