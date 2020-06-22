//
//  ViewController.swift
//  My Xylophone
//
//  Created by 윤병일 on 2020/06/21.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  var player : AVAudioPlayer!
  
  //MARK: - Properties
  private let cButton : UIButton = {
    let bt = UIButton(type: .system)
    bt.setTitle("C", for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = .systemRed
    bt.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    return bt
  }()
  
  private let dButton : UIButton = {
    let bt = UIButton(type: .system)
    bt.setTitle("D", for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    bt.backgroundColor = .systemOrange
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    return bt
  }()
  
  private let eButton : UIButton = {
    let bt = UIButton(type: .system)
    bt.setTitle("E", for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    bt.backgroundColor = .systemYellow
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    return bt
  }()
  
  private let fButton : UIButton = {
    let bt = UIButton(type: .system)
    bt.setTitle("F", for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    bt.backgroundColor = .systemGreen
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    return bt
  }()
  
  private let gButton : UIButton = {
    let bt = UIButton(type: .system)
    bt.setTitle("G", for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    bt.backgroundColor = .systemTeal
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    return bt
  }()
  
  private let aButton : UIButton = {
    let bt = UIButton(type: .system)
    bt.setTitle("A", for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    bt.backgroundColor = .systemBlue
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    return bt
  }()
  
  private let bButton : UIButton = {
    let bt = UIButton(type: .system)
    bt.setTitle("B", for: .normal)
    bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    bt.backgroundColor = .systemPurple
    bt.setTitleColor(.white, for: .normal)
    bt.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    return bt
  }()
  
  //MARK: - viewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureUI()
  }
  
  
  //MARK: - @objc didTapButton
  @objc func didTapButton(_ sender : UIButton) {
    playSound(soundName: sender.currentTitle!)
    
    sender.alpha = 0.5
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      sender.alpha = 1.0
    }
  }
  
  //MARK: - configureUI()
  func configureUI() {
    
    view.addSubview(cButton)
    cButton.translatesAutoresizingMaskIntoConstraints = false
    cButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    cButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    cButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    cButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    view.addSubview(dButton)
    dButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dButton.topAnchor.constraint(equalTo: cButton.bottomAnchor, constant: 10),
      dButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
      dButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
      dButton.heightAnchor.constraint(equalToConstant: 100)
    ])
    
    view.addSubview(eButton)
    eButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      eButton.topAnchor.constraint(equalTo: dButton.bottomAnchor, constant: 10),
      eButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      eButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      eButton.heightAnchor.constraint(equalToConstant: 100)
    ])
    
    view.addSubview(fButton)
     fButton.translatesAutoresizingMaskIntoConstraints = false
     NSLayoutConstraint.activate([
       fButton.topAnchor.constraint(equalTo: eButton.bottomAnchor, constant: 10),
       fButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
       fButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
       fButton.heightAnchor.constraint(equalToConstant: 100)
     ])
    
    view.addSubview(gButton)
       gButton.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
         gButton.topAnchor.constraint(equalTo: fButton.bottomAnchor, constant: 10),
         gButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
         gButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
         gButton.heightAnchor.constraint(equalToConstant: 100)
       ])
    
    view.addSubview(aButton)
        aButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          aButton.topAnchor.constraint(equalTo: gButton.bottomAnchor, constant: 10),
          aButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
          aButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
          aButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    
    view.addSubview(bButton)
        bButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          bButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 10),
          bButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
          bButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
          bButton.heightAnchor.constraint(equalToConstant: 80)
        ])
  }
  
  //MARK: - func playSound
  func playSound (soundName : String) {
    let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
  }
  
  
  
}



