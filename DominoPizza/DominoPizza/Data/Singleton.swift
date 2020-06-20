//
//  Singleton.swift
//  DominoPizza
//
//  Created by 윤병일 on 2020/06/20.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation


final class Singleton {
  static let standard = Singleton()
  
  
  var wishListDict : [String : Int] = [:]
}
