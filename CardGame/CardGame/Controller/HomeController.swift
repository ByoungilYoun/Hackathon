//
//  HomeController.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/04.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit
import Firebase

class HomeController : UIViewController {
  
  //MARK: - Properties
  private var cardGameBrain = CardGameBrain()
  private var gameBoard = Board()
  weak var delegate: HomeViewControllerDelegate?
  private lazy var score: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(cardGameBrain.turnsLeft, for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
    button.addTarget(self, action: #selector(handleScoreButton(_:)), for: .touchUpInside)
    return button
  }()
  private lazy var resetButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Reset", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    button.addTarget(self, action: #selector(handleResetButton(_:)), for: .touchUpInside)
    return button
  }()
  private var turnsLeft: String {
    get {
      return String(cardGameBrain.turnsLeftTillGameOver()) // 유저에게 몇 번의 기회가 남았는지를 돌려준다.
    }
    set {
      print("Setting up Score...", newValue)
      score.titleLabel?.text = newValue // turn 레이블 업데이트
      score.setTitle(newValue, for: .normal)
    }
  }
  private lazy var horizontalNumberOfLinesNeededToPlaceCards = cardGameBrain.numberOfLinesNeedToPlaceCards
  private var currentGameMode: GameModes = .expert // 유저가 선택한 게임모드를 저장
  
  private var user : User? {
    didSet {
      presentOnboardingIfNeccessary()
      showWelcomeLabel()
    }
  }
  
  private let welcomeLabel : UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.text = "환영합니다"
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.alpha = 0
    return label
  }()
  //MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    authenticateUser()
    initailizeCardGame()
    configureUI()
  }
  
  //MARK: - Selectors
  @objc func handleScoreButton(_ sender: UIButton) {
    let alert = UIAlertController(title: "난이도 변경", message: "원하는 난이도를 선택해주세요", preferredStyle: .actionSheet)
    let easyAlertAction = UIAlertAction(title: "쉬움", style: .default, handler: { _ in self.currentGameMode = .easy; self.restartGame() })
    let hardAlertAction = UIAlertAction(title: "어려움", style: .default, handler: { _ in self.currentGameMode = .hard; self.restartGame() })
    let expertAlertAction = UIAlertAction(title: "매우 어려움", style: .default, handler: { _ in self.currentGameMode = .expert; self.restartGame();})
    let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    [expertAlertAction, hardAlertAction, easyAlertAction, cancelAlertAction].forEach { alert.addAction($0) }
    present(alert, animated: true)
  }
  
  @objc func handleResetButton(_ sender: UIButton) {
    restartGame()
  }
  
  @objc func cardSelected(_ card: Cards) {
    cardGameBrain.flipCard(card)
    guard cardGameBrain.countSelectedCards() == 2 else { print("Less than two card selected"); return } // 유저가 카드 2장을 오픈했다면...
    var result = false
    DispatchQueue.main.asyncAfter(
      deadline: .now() + 0.10,
      execute: {
        result = self.cardGameBrain.checkAnswer()
        self.turnsLeft = self.updateTurns()
    })
    DispatchQueue.main.asyncAfter(
      deadline: .now() + 0.75,
      execute: {
        print("Excute Performed, number of cards: \(self.cardGameBrain.countSelectedCards()), number of images: \(self.cardGameBrain.imagesThatUserHasChosen)")
        
        result ? self.cardGameBrain.removeCardsFromTheBoard(self.gameBoard) : self.cardGameBrain.unflipCard(self.gameBoard)
        self.turnsLeft = self.updateTurns()
    })
  }
  
  @objc func handleLogout() {
    let alert = UIAlertController(title: nil, message: "로그아웃 하시겠습니까?", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { _ in
      self.logout()
      
    }))
    
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  
  //MARK: - API
  // 유저 인포메이션을 가져온다 
  func fetchUser() {
    Service.fetchUser { user in
      self.user = user
    }
  }
  
  
  func logout() {
    do {
      try Auth.auth().signOut()
      self.presentLoginController()
      
      print("debug : signed out")
    } catch  {
      print("debug : signing out")
    }
  }
  
  
  
  func authenticateUser() {
    if Auth.auth().currentUser?.uid == nil {
      // 로그인이 안되어있을때 로그인 뷰가 나온다.
      DispatchQueue.main.async {
        self.presentLoginController()
      }
    } else {
      fetchUser()
    }
  }
  
  //MARK: - Helpers
  
  func configureUI() {
    sendDataToBoard()
    configureGradientBackground()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.barStyle = .black
    navigationItem.title = "카드게임"
    
    let image = UIImage(systemName: "arrow.left")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image , style: .plain, target: self, action: #selector(handleLogout))
    navigationItem.leftBarButtonItem?.tintColor = .white
    
    view.addSubview(welcomeLabel)
    welcomeLabel.centerX(inView: view)
    welcomeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
    //welcomeLabel.centerX(inView: view)
    //welcomeLabel.centerY(inView: view)
    let safeArea = view.safeAreaLayoutGuide
    let navigationBar = navigationController!.navigationBar
    [gameBoard, resetButton].forEach { view.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }
    navigationBar.addSubview(score)
    score.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      gameBoard.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 55),
      gameBoard.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 35),
      gameBoard.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -35),
      gameBoard.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -85),
      
      score.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -3),
      score.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -25),
      
      resetButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
      resetButton.topAnchor.constraint(equalTo: gameBoard.bottomAnchor, constant: 30)
    ])
    
    
  }
  
  fileprivate func showWelcomeLabel() {
    guard let user = user else { return }
    guard user.hasSeenOnboarding else { return }
    
    welcomeLabel.text = "환영합니다! \(user.fullname) 님"
    
    UIView.animate(withDuration: 0.5) {
      self.welcomeLabel.alpha = 1
    }
  }
  
  // 유저가 로그인 되어있는지 아닌지 알려주는 함수, Refactor 사용
  fileprivate func presentLoginController() {
    
    let controller = LoginController()
    controller.delegate = self
    let navi = UINavigationController(rootViewController: controller )
    navi.modalPresentationStyle = .fullScreen
    self.present(navi, animated: true)
  }
  
  fileprivate func presentOnboardingIfNeccessary() {
    guard let user = user else { return }
    guard !user.hasSeenOnboarding else { return }
    let controller = OnboardingController()
    controller.delegate = self
    controller.modalPresentationStyle = .fullScreen
    present(controller, animated: true, completion: nil)
  }
  
  // MARK: - Private Methods
  private func initailizeCardGame() {
    cardGameBrain.generateGameInfo()
    arrangeCardsIntoSubviewsAndAddActions()
    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { self.unflipAllCards() })
  }

  private func arrangeCardsIntoSubviewsAndAddActions() {
    let card = cardGameBrain.inGameCards
    var imageCounter = 0
    var subviewCounter = 0
    for subview in gameBoard.arrayOfStackViews {
      subviewCounter += 1
      if subviewCounter > cardGameBrain.numberOfLinesNeedToPlaceCards {
        break
      }
      while subview.arrangedSubviews.count < 4 {
        subview.addArrangedSubview(card[imageCounter])
        card[imageCounter].addTarget(self, action: #selector(cardSelected(_:)), for: .touchUpInside)
        imageCounter += 1
      }
    }
  }

  private func unflipAllCards() {
    let parentStack = gameBoard.arrayOfStackViews
    for childStack in parentStack {
      for view in childStack.subviews {
        guard let card = view as? Cards else { return }
        card.isFlipped = false
      }
    }
  }

  private func updateTurns() -> String {
    guard cardGameBrain.gameCleared() == false else {
      let alert = UIAlertController(title: "Game Clear", message: "축하합니다!!", preferredStyle: .alert)
      alert.addAction(UIAlertAction(
        title: "확인",
        style: .cancel,
        handler: {
          _ in self.restartGame()
      }))
      present(alert, animated: true)
      return cardGameBrain.turnsLeft
    }
    guard cardGameBrain.gameOver() == false else {
      let alert = UIAlertController(title: "Game Over", message: "다음에는 꼭 성공할 수 있을거에요!", preferredStyle: .alert)
      alert.addAction(UIAlertAction(
        title: "확인",
        style: .cancel,
        handler: {
          _ in self.restartGame()
      }))
      present(alert, animated: true)
      return cardGameBrain.turnsLeft }
    return cardGameBrain.turnsLeft
  }

  private func restartGame() {
    cardGameBrain = CardGameBrain(gameMode: currentGameMode)
    gameBoard = Board()
    configureUI()
    initailizeCardGame()
    turnsLeft = updateTurns()
  }
  
}
//MARK: - OnboardingControllerDelegate

extension HomeController : OnboardingControllerDelegate {
  func controllerWantsToDismiss(_ controller: OnboardingController) {
    controller.dismiss(animated: true, completion: nil)
    Service.updateUserHasSeenOnboarding { (error , ref) in
      self.user?.hasSeenOnboarding = true 
    }
  }
}

extension HomeController : AuthenticationDelegate {
  func authenticationComplete() {
    dismiss(animated: true, completion: nil)
    
    fetchUser()
  }
}





// MARK: - Extension
extension HomeController {
  private func sendDataToBoard() {
    self.delegate = gameBoard
    self.delegate?.sendNumberOfLinesNeeded(lines: horizontalNumberOfLinesNeededToPlaceCards)
  }
}


// MARK: - Delegate Protocol
protocol HomeViewControllerDelegate: class {
  func sendNumberOfLinesNeeded(lines: Int)
}
