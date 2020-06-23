//
//  ViewController.swift
//  My Egg Timer
//
//  Created by 윤병일 on 2020/06/22.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //MARK: - Properties
    private let progressBar : UIProgressView = {
        let pb  = UIProgressView(progressViewStyle: .bar)
        pb.setProgress(0.1, animated: true)
        pb.trackTintColor = UIColor.lightGray
        pb.tintColor = UIColor.yellow
        return pb
    }()
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.text = "How do you like your eggs?"
        lb.textAlignment = .center
        lb.font = UIFont.preferredFont(forTextStyle: .title2)
        lb.textColor = .black
        return lb
    }()
    
    private let button1 : UIButton = {
        let bt = UIButton()
        bt.setTitle("Soft", for: .normal)
        bt.setImage(UIImage(named: "soft_egg"), for: .normal)
        bt.addTarget(self, action: #selector(hardnessSelected(_:)), for: .touchUpInside)
        return bt
    }()
    
    private let button2 : UIButton = {
        let bt = UIButton()
        bt.setTitle("Medium", for: .normal)
        bt.setImage(UIImage(named: "medium_egg"), for: .normal)
        bt.addTarget(self, action: #selector(hardnessSelected(_:)), for: .touchUpInside)
        return bt
    }()
    
    private let button3 : UIButton = {
        let bt = UIButton()
        bt.setTitle("Hard", for: .normal)
        bt.setImage(UIImage(named: "hard_egg"), for: .normal)
        bt.addTarget(self, action: #selector(hardnessSelected(_:)), for: .touchUpInside)
        return bt
    }()
    
    var timer = Timer()
    var player : AVAudioPlayer!
    let eggTimes = ["Soft": 3, "Medium" : 4 , "Hard" : 7]
    var totalTime = 0
    var secondPassed = 0
    
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupUI()
    }
  
    
    private func setupUI() {
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    
        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 330),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            progressBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }

    @objc func hardnessSelected(_ sender : UIButton) {
        timer.invalidate() // 무효화
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer () {
        if secondPassed < totalTime {
            secondPassed += 1
            progressBar.progress = Float(secondPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}

