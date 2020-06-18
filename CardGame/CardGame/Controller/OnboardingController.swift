//
//  OnboardingController.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/04.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation
import paper_onboarding // 이미 이것이 UIKit 을 import 하고있다.

// onboarding 을 사라지게끔 하는 프로토콜
protocol  OnboardingControllerDelegate : class {
  func controllerWantsToDismiss(_ controller : OnboardingController)
}

class OnboardingController : UIViewController {
  
  
  //MARK: - Properties
  
  weak var delegate : OnboardingControllerDelegate?
  private var onboardingItems = [OnboardingItemInfo]()
  private var onboardingView = PaperOnboarding()
  
  private let getStartedButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("게임 시작!", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    button.addTarget(self, action: #selector(dismissOnboarding), for: .touchUpInside)
    return button
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureOnboardingDataSource()
    
    
  }
  
  override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
  
  //MARK: - Selectors
  
  @objc func dismissOnboarding () {
    delegate?.controllerWantsToDismiss(self)
  }
  
  //MARK: - Helpers
  
  // 버튼 맨 마지막에 보여주기
  func animateGetStartedButton(_ shouldShow : Bool) {
    let alpha : CGFloat = shouldShow ? 1 : 0
    UIView.animate(withDuration: 0.5) {
      self.getStartedButton.alpha = alpha
    }
    
  }
  
  
  
  func configureUI(){
    view.addSubview(onboardingView)
    onboardingView.fillSuperview()
    onboardingView.delegate = self
    
    view.addSubview(getStartedButton)
    getStartedButton.alpha = 0
    getStartedButton.centerX(inView: view)
    getStartedButton.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 128)
  }
  
  // onboarding 아이템 셋업
  func configureOnboardingDataSource() {
    let item1 = OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "baseline_dashboard_white_48pt").withRenderingMode(.alwaysOriginal), title: MSG_CARDGAME, description: MSG_ONBOARDING_CARDGAME, pageIcon: UIImage(), color: .systemPurple, titleColor: .white, descriptionColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 24), descriptionFont: UIFont.systemFont(ofSize: 16))
    
    let item2 = OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "ic_person_outline_white_2x").withRenderingMode(.alwaysOriginal), title: MSG_MEMORY, description: MSG_ONBOARDING_MEMORY, pageIcon: UIImage(), color: .systemBlue, titleColor: .white, descriptionColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 24), descriptionFont: UIFont.systemFont(ofSize: 16))
    
    let item3 = OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "baseline_insert_chart_white_48pt").withRenderingMode(.alwaysOriginal), title: MSG_RANKING, description: MSG_ONBOARDING_RANKING, pageIcon: UIImage(), color: .systemPink, titleColor: .white, descriptionColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 24), descriptionFont: UIFont.systemFont(ofSize: 16))
    
    onboardingItems.append(item1)
    onboardingItems.append(item2)
    onboardingItems.append(item3)
    
    onboardingView.dataSource = self // item1 을 적고 나서 뒤에 써줘야 한다.
    onboardingView.reloadInputViews()
  }
}

//MARK: - Extension
extension OnboardingController : PaperOnboardingDataSource {
  func onboardingItemsCount() -> Int {
    return onboardingItems.count
  }
  
  func onboardingItem(at index: Int) -> OnboardingItemInfo {
    return onboardingItems[index]
  }
  
  
}

// 시작 버튼이 맨 마지막에 나타나도록
extension OnboardingController : PaperOnboardingDelegate {
  func onboardingWillTransitonToIndex(_ index : Int) {
    let viewModel = OnboardingViewModel(itemCount: onboardingItems.count)
    let shouldShow = viewModel.shouldShowGetStartedButton(forIndex: index)
    animateGetStartedButton(shouldShow)
  }
}
