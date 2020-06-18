//
//  AuthenticationViewModel.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/03.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

//MARK: - Protocol
protocol AuthenticationViewModel {
  var formIsValid : Bool {get}
  var shouldEnableButton : Bool {get}
  var buttonTitleColor : UIColor {get}
  var buttonBackgroundColor : UIColor {get}
}

protocol FormViewModel {
  func updateForm()
}

//MARK: - LoginViewModel
struct LoginViewModel : AuthenticationViewModel {
  var email : String?
  var password: String?
  
  // 이메일텍스트 필드와 패스워드텍스트 필드 둘다 값이 있을 경우 true 아니면 false
  var formIsValid : Bool {
    return email?.isEmpty == false && password?.isEmpty == false
  }
  
  // formIsValid 가 true 이면 버튼이 enabled 되게 한다
  var shouldEnableButton : Bool {
    return formIsValid
  }
  
  var buttonTitleColor : UIColor {
    return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
  }
  
  var buttonBackgroundColor : UIColor {
    let enabledPurple = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)   // = 뒤에 Color Literal 써주면 된다.
    let disabledPurple =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    return formIsValid ? enabledPurple : disabledPurple
  }
}

//MARK: - RegistrationViewModel
struct RegistrationViewModel : AuthenticationViewModel{
  var email : String?
  var password: String?
  var fullname : String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false
  }
  
  var shouldEnableButton : Bool {
    return formIsValid
  }
  
  var buttonTitleColor : UIColor {
    return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
  }
  
  var buttonBackgroundColor : UIColor {
    let enabledPurple = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)   // = 뒤에 Color Literal 써주면 된다.
    let disabledPurple =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    return formIsValid ? enabledPurple : disabledPurple
  }
}

struct ResetPasswordViewModel : AuthenticationViewModel{
  
  var email : String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false
  }
  
  var shouldEnableButton : Bool {
    return formIsValid
  }
  
  var buttonTitleColor : UIColor {
    return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
  }
  
  var buttonBackgroundColor : UIColor {
    let enabledPurple = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)   // = 뒤에 Color Literal 써주면 된다.
    let disabledPurple =  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    return formIsValid ? enabledPurple : disabledPurple
  }
  
}
