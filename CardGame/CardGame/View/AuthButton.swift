//
//  AuthButton.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/03.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class AuthButton : UIButton {
  
  var title : String? {
    didSet {
      setTitle(title, for: .normal)
    }
  }
  

  override init(frame: CGRect) {
    super.init(frame : frame)
    
    layer.cornerRadius = 5
    backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5) // Color Literal 을 써주면된다
    setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
    setHeight(height: 40)
    isEnabled = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
