//
//  MainTabBarController.swift
//  DominoPizza
//
//  Created by 윤병일 on 2020/06/20.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let categoryVC = UINavigationController(rootViewController: CategoryViewController())
    categoryVC.tabBarItem = UITabBarItem(title: "Category", image: UIImage(named: "domino's"), tag: 0)
    
    let wishListVC = UINavigationController(rootViewController: WishListViewController())
    wishListVC.tabBarItem = UITabBarItem(title: "Wish List", image: UIImage(named: "wishlist"), tag: 0)
    
    viewControllers = [categoryVC, wishListVC]
    
  }
}
