//
//  LoginController.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/03.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

protocol  AuthenticationDelegate : class {
  
  func authenticationComplete()
}

class LoginController : UIViewController {
  
  //MARK: - Properties
  private var viewModel = LoginViewModel()
  weak var delegate : AuthenticationDelegate?
  
  private let iconImage = UIImageView(image: #imageLiteral(resourceName: "icon2"))
  
  private let emailTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "이메일")
    tf.keyboardType = .emailAddress
    return tf
  }()
  
  private let passwordTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "비밀번호")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let loginButton : AuthButton = {
    let button = AuthButton(type: .system)
    button.title = "로그인"
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    return button
  }()
  
  private let forgotButton : UIButton = {
    let button = UIButton(type: .system)
    
    let atts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 15)]
    let attributedTitle = NSMutableAttributedString(string: "비밀번호를 잊어버리셨나요?", attributes: atts)
    
    let boldAtts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 15)]
    attributedTitle.append(NSAttributedString(string: " 여기를 클릭하세요", attributes: boldAtts))
    
    button.setAttributedTitle(attributedTitle, for: .normal)
    
    button.addTarget(self, action: #selector(showForgotPassword), for: .touchUpInside)
    return button
  }()
  
  private let dividerView = DividerView()
  
  private let googleLoginButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "btn_google_light_pressed_ios").withRenderingMode(.alwaysOriginal), for: .normal)
    button.setTitle("구글로 로그인 하기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action:#selector(handleGoogleLogin) , for: .touchUpInside)
    return button
  }()
  
  private let dontHaveAccountButton : UIButton = {
    let button = UIButton(type: .system)
    
    let atts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 15)]
    let attributedTitle = NSMutableAttributedString(string: "아직 계정이 없으신가요?", attributes: atts)
    
    let boldAtts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 15)]
    attributedTitle.append(NSAttributedString(string: " 계정 생성", attributes: boldAtts))
    
    button.setAttributedTitle(attributedTitle, for: .normal)
    
    button.addTarget(self, action: #selector(showRegisterationController), for: .touchUpInside)
    return button
  }()
  
  
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    emailTextField.delegate = self
    passwordTextField.delegate = self
    configureUI()
    configureNotificationObservers()
    configureGoogleSignIn()
    
    
  }
  
  //MARK: - Selectors
  @objc func handleLogin() {
    guard let email = emailTextField.text else {return}
    guard let password = passwordTextField.text else {return}
    
    showLoader(true)
    
    Service.logUserIn(withEmail: email, password: password) { (result, error) in
       self.showLoader(false)
      if error != nil {
        self.showMessage(withTitle: "", message: "이메일 또는 비밀번호가 잘못된 형식입니다.")
       
             return
           }
    
      self.delegate?.authenticationComplete()
    }
  }
  
  @objc func showForgotPassword() {
    let controller = ResetPasswordController()
    controller.email = emailTextField.text
    controller.delegate = self
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func handleGoogleLogin() {
    GIDSignIn.sharedInstance()?.signIn()
  }
  
  @objc func showRegisterationController() {
     let controller = RegisterationController()
    controller.delegate = delegate
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func textDidChange(_ sender: UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else {
      viewModel.password = sender.text
    }
    //print("Debug : form is valid \(viewModel.formIsValid)")
    updateForm()
  }
  
  //MARK: - Helpers
  func configureUI() {
    // 위에 네비게이션 바 숨김
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    
    //그라데이션 함수
    configureGradientBackground()
    
    // 아이콘 이미지
    view.addSubview(iconImage)
    iconImage.centerX(inView: view)
    iconImage.setDimensions(height: 120, width: 120)
    iconImage.anchor(top : view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    
    //스택 뷰 사용
    let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
    stackView.axis = .vertical
    stackView.spacing = 20
    view.addSubview(stackView)
    stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30 , paddingLeft: 30, paddingRight: 30)
    
    let stackView2 = UIStackView(arrangedSubviews: [ forgotButton, dividerView, googleLoginButton])
    stackView2.axis = .vertical
    stackView2.spacing = 20
    view.addSubview(stackView2)
    stackView2.anchor(top: stackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24 , paddingLeft: 30, paddingRight: 30)
    
    view.addSubview(dontHaveAccountButton)
    dontHaveAccountButton.centerX(inView: view)
    dontHaveAccountButton.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10)
    
  }
  
  // 이메일텍스트필드와 패스워드 텍스트필드에 입력 감지
  func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
  
  //구글 Sign In
  func configureGoogleSignIn () {
    GIDSignIn.sharedInstance()?.presentingViewController = self
    GIDSignIn.sharedInstance()?.delegate = self
  }
}


//MARK: - FormViewModel
extension LoginController : FormViewModel {
  func updateForm() {
     loginButton.isEnabled = viewModel.shouldEnableButton
     loginButton.backgroundColor = viewModel.buttonBackgroundColor
     loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
   }
}

//MARK: - GIDSignInDelegate

extension LoginController : GIDSignInDelegate {
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    Service.signInWithGoogle(didSignInFor: user) { (error, ref) in
      self.delegate?.authenticationComplete()
    }
  }
}

//MARK: - ResetPasswordControllerDelegate 
extension LoginController : ResetPasswordControllerDelegate {
  func didSendResetPasswordLink() {
    navigationController?.popViewController(animated: true)
    self.showMessage(withTitle: "", message: MSG_RESET_PASSWORD_LINK_SENT)
         
  }
}

// MARK: - UITextFieldDelegate 
extension LoginController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
}
