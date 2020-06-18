//
//  Extensions.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/03.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit
import JGProgressHUD

extension UIView {
  func anchor(top: NSLayoutYAxisAnchor? = nil,
              left: NSLayoutXAxisAnchor? = nil,
              bottom: NSLayoutYAxisAnchor? = nil,
              right: NSLayoutXAxisAnchor? = nil,
              paddingTop: CGFloat = 0,
              paddingLeft: CGFloat = 0,
              paddingBottom: CGFloat = 0,
              paddingRight: CGFloat = 0,
              width: CGFloat? = nil,
              height: CGFloat? = nil) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    
    if let width = width {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if let height = height {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = nil) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    if let topAnchor = topAnchor, let padding = paddingTop {
      self.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
    }
  }
  
  func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
               paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
    
    translatesAutoresizingMaskIntoConstraints = false
    centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    
    if let left = leftAnchor {
      anchor(left: left, paddingLeft: paddingLeft)
    }
  }
  
  func setDimensions(height: CGFloat, width: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: height).isActive = true
    widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func setHeight(height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func setWidth(width: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func fillSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superviewTopAnchor = superview?.topAnchor,
      let superviewBottomAnchor = superview?.bottomAnchor,
      let superviewLeadingAnchor = superview?.leftAnchor,
      let superviewTrailingAnchor = superview?.rightAnchor else { return }
    
    anchor(top: superviewTopAnchor, left: superviewLeadingAnchor,
           bottom: superviewBottomAnchor, right: superviewTrailingAnchor)
  }
}

extension UIViewController {
  static let hud = JGProgressHUD(style: .dark)
  
  
  func configureGradientBackground() {
    // 그레디언트 속성
    
    let upperColor = UIColor(red: 205/255.0, green: 53/255.0, blue: 134/255.0, alpha: 1.0)
    let lowerColor = UIColor(red: 233/255.0, green: 171/255.0, blue: 67/255.0, alpha: 1.0)
    let gradient = CAGradientLayer()
    gradient.colors = [upperColor.cgColor, lowerColor.cgColor]
    gradient.locations = [0,1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }
  
  // 로그인시 로딩되면서 밑으로 화면 내려가기 
  func showLoader(_ show : Bool) {
    view.endEditing(true)
    
    if show {
      UIViewController.hud.show(in: view)
    } else {
      UIViewController.hud.dismiss()
    }
  }
  
  func showMessage(withTitle title : String, message : String) {
    let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

