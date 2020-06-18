//
//  CustomTextField.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/03.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class CustomTextField : UITextField {
  
  init(placeholder : String) {
    super.init(frame : .zero)
    
    // 텍스트필드 옆 빈 공간 생성
    let spacer = UIView()
    spacer.setDimensions(height: 50, width: 12)
    leftView = spacer
    leftViewMode = .always
    
    borderStyle = .none
    textColor = .white
    keyboardAppearance = .dark
    backgroundColor = UIColor(white: 1, alpha: 0.1)
    setHeight(height: 50)
    attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor(white: 1.0, alpha: 0.7)])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
