//
//  RegisterationController.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/03.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit
import Firebase

class RegisterationController : UIViewController {
  
  //MARK: - Properties
  private var viewModel = RegistrationViewModel()
  
  private let iconImage = UIImageView(image: #imageLiteral(resourceName: "icon2"))
  weak var delegate : AuthenticationDelegate?
  
  private let emailTextField = CustomTextField(placeholder: "이메일")
  private let fullnameTextField = CustomTextField(placeholder: "성명")
  
  private let passwordTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "비밀번호")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let signUpButton : AuthButton = {
    let button = AuthButton(type: .system)
    button.title = "계정 생성"
    button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    return button
  }()
  
  private let alreadyHaveAccountButton : UIButton = {
    let button = UIButton(type: .system)
    
    let atts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 15)]
    let attributedTitle = NSMutableAttributedString(string: "아이디가 있으신가요?", attributes: atts)
    
    let boldAtts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 15)]
    attributedTitle.append(NSAttributedString(string: " 로그인하기", attributes: boldAtts))
    
    button.setAttributedTitle(attributedTitle, for: .normal)
    
    button.addTarget(self, action: #selector(showLoginController), for: .touchUpInside)
    return button
  }()
  
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    emailTextField.delegate = self
    passwordTextField.delegate = self
    fullnameTextField.delegate = self
    configureUI()
    configureNotificationObservers()
  }
  
  //MARK: - Selectors
  
  @objc func handleSignUp () {
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    guard let fullname = fullnameTextField.text else { return }
    
    showLoader(true)
    
    Service.registerUserWithFirebase(withEmail: email, password: password, fullname: fullname) { (error , ref) in
      self.showLoader(false)
      
      if error != nil {
        self.showMessage(withTitle: "", message: "이메일 또는 비밀번호 형식이 아닙니다.")
             
        
        return
      }
      
      self.delegate?.authenticationComplete()
    }
  }
  
  @objc func showLoginController() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func textDidChange(_ sender: UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else if sender == passwordTextField {
      viewModel.password = sender.text
    } else {
      viewModel.fullname = sender.text
    }
    updateForm()
  }
  
  //MARK: - Helpers
  func configureUI() {
    
    configureGradientBackground()
    
    // 아이콘 이미지
    view.addSubview(iconImage)
    iconImage.centerX(inView: view)
    iconImage.setDimensions(height: 120, width: 120)
    iconImage.anchor(top : view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    
    //스택 뷰 사용
    let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, signUpButton])
    stackView.axis = .vertical
    stackView.spacing = 20
    view.addSubview(stackView)
    stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30 , paddingLeft: 30, paddingRight: 30)
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.centerX(inView: view)
    alreadyHaveAccountButton.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10)
  }
  
  func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
}

//MARK: - FormViewModel
extension RegisterationController : FormViewModel {
  func updateForm() {
    signUpButton.isEnabled = viewModel.shouldEnableButton
    signUpButton.backgroundColor = viewModel.buttonBackgroundColor
    signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}

//MARK: - UITextFieldDelegate
extension RegisterationController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
}
