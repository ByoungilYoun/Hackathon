//
//  ViewController.swift
//  Youn Quiz
//
//  Created by 윤병일 on 2020/06/25.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //MARK: - Properties
  
  private var questionLabel = UILabel()
  private var trueButton = UIButton()
  private var falseButton = UIButton()
  private var progressBar = UIProgressView()
  private let scoreLabel = UILabel()

  var quizBrain = QuizBrain()
  //MARK: - viewDidLoad()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setGradientColor()
    setUI()
    setConstraint()
    
  }
  
  //MARK: - func setUI()
  private func setUI() {
    
    questionLabel.text = quizBrain.getQuestion()
    questionLabel.textColor = .white
    questionLabel.textAlignment = .left
    questionLabel.numberOfLines = 0
    view.addSubview(questionLabel)
    
    
    trueButton.setTitle("True", for: .normal)
    trueButton.setTitleColor(.black, for: .normal)
    trueButton.titleLabel?.font = .preferredFont(forTextStyle: .title2)
    trueButton.backgroundColor = .systemPurple
    trueButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    view.addSubview(trueButton)
    
    falseButton.setTitle("False", for: .normal)
    falseButton.setTitleColor(.black, for: .normal)
    falseButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
    falseButton.backgroundColor = .systemPurple
    falseButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    view.addSubview(falseButton)
    
    progressBar.progressViewStyle = .bar
    progressBar.setProgress(0.2, animated: true)
    progressBar.trackTintColor = UIColor.lightGray
    progressBar.tintColor = .yellow
    view.addSubview(progressBar)
    
    scoreLabel.text = "0"
    scoreLabel.textColor = .black
    scoreLabel.textAlignment = .left
    view.addSubview(scoreLabel)
    
  }
  //MARK: - func setConstraint()
  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
    
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    scoreLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30).isActive = true
    scoreLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    scoreLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    questionLabel.translatesAutoresizingMaskIntoConstraints = false
    questionLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 30).isActive = true
    questionLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
    questionLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
    questionLabel.heightAnchor.constraint(equalToConstant: 250).isActive = true
    
    trueButton.translatesAutoresizingMaskIntoConstraints = false
    trueButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 100).isActive = true
    trueButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 100).isActive = true
    trueButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -100).isActive = true
    trueButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    falseButton.translatesAutoresizingMaskIntoConstraints = false
    falseButton.topAnchor.constraint(equalTo: trueButton.bottomAnchor, constant: 30).isActive = true
    falseButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 100).isActive = true
    falseButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -100).isActive = true
    falseButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    progressBar.translatesAutoresizingMaskIntoConstraints = false
    progressBar.topAnchor.constraint(equalTo: falseButton.bottomAnchor, constant: 50).isActive = true
    progressBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 20).isActive = true
    progressBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -20).isActive = true
    progressBar.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
  }
  //MARK: - buttonClicked
  @objc func buttonClicked (_ sender : UIButton) {
    let userAnswer = sender.currentTitle!
    let userGotItRight = quizBrain.checkAnswer(userAnswer)
  
    if userGotItRight {
      sender.backgroundColor = UIColor.green
    } else {
      sender.backgroundColor = UIColor.red
    }
    
    quizBrain.nextQuestion()
  
    
    Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false )
    
  }
  
  //MARK: - @objc func updateUI()
  
  @objc func updateUI() {
    questionLabel.text = quizBrain.getQuestion()
    progressBar.progress = quizBrain.getProgress()
    scoreLabel.text = "Score : \(quizBrain.getScore())"
    trueButton.backgroundColor = UIColor.purple
    falseButton.backgroundColor = UIColor.purple
   
  }
  
  func setGradientColor() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.blue.cgColor, UIColor.orange.cgColor]
    gradient.locations = [0, 1]
    gradient.frame = view.frame
    view.layer.addSublayer(gradient)
  }
}

