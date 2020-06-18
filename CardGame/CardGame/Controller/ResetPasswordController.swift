//
//  ResetPasswordController.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/03.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

protocol ResetPasswordControllerDelegate : class {
  func didSendResetPasswordLink()
}

class ResetPasswordController : UIViewController {
  
  //MARK: - Properties
  
  private var viewModel = ResetPasswordViewModel()
  weak var delegate : ResetPasswordControllerDelegate?
  var email : String? 
  
  private let iconImage = UIImageView(image: #imageLiteral(resourceName: "icon2"))
  private let emailTextField = CustomTextField(placeholder: "이메일")
  
  private let resetPasswordButton : AuthButton = {
    let button = AuthButton(type: .system)
    button.title = "비밀번호 초기화 링크 보내기"
    button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    return button
  }()
  
  private let backButton : UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    return  button
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    emailTextField.delegate = self
    configureUI()
    configureNotificationObservers()
    loadEmail()
  }
  
  //MARK: - Selectors
  @objc func handleResetPassword(){
    guard let email = viewModel.email else {return}
    
    showLoader(true)
    
    Service.resetPassword(forEmail: email) { error in
      self.showLoader(false)
      if error != nil {
         self.showMessage(withTitle: "", message: "잘못된 이메일 형식입니다.")
        return
      }
      self.delegate?.didSendResetPasswordLink()
    }
  }
  
  @objc func handleDismissal() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func textDidChange(_ sender: UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    }
    updateForm()
  }
  
  //MARK: - Helpers
  
  func configureUI() {
    
    configureGradientBackground()
    
    // back버튼 추가
    view.addSubview(backButton)
    backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
    
    // 아이콘 이미지
    view.addSubview(iconImage)
    iconImage.centerX(inView: view)
    iconImage.setDimensions(height: 120, width: 120)
    iconImage.anchor(top : view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    
    //스택 뷰 사용
    let stackView = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
    stackView.axis = .vertical
    stackView.spacing = 20
    view.addSubview(stackView)
    stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30 , paddingLeft: 30, paddingRight: 30)
  }
  
  func loadEmail() {
    guard let email = email else { return }
    viewModel.email = email
    emailTextField.text = email
    updateForm()
    
  }
  
  func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    
  }
}
//MARK: - FormViewModel
extension ResetPasswordController : FormViewModel {
  func updateForm() {
    resetPasswordButton.isEnabled = viewModel.shouldEnableButton
    resetPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
    resetPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}


// MARK: - UITextFieldDelegate 
extension ResetPasswordController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
}
