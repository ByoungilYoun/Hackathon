//
//  OnboardingViewModel.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/05.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//
// OnboardingViewModel 의 버튼 나중에 나타내기 위해 extension의 함수 정리 
import Foundation
import paper_onboarding


struct OnboardingViewModel {
  
  private let itemCount : Int
  
  init(itemCount : Int) {
    self.itemCount = itemCount
  }
  
  func shouldShowGetStartedButton(forIndex index : Int) -> Bool {
    return index == itemCount - 1 ? true : false
  }
}
