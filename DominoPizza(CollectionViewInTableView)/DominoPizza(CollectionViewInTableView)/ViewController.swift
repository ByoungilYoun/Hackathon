//
//  ViewController.swift
//  DominoPizza(CollectionViewInTableView)
//
//  Created by 윤병일 on 2020/07/05.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  //MARK: - Properties
  
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    setUI()
    setConstraint()
    
  }
  //MARK: - UI
  
  private func setNavigation() {
    navigationItem.title = "Domino's"
  }
  
  private func setUI() {
    view.backgroundColor = .systemBackground
    
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.identifier)
    view.addSubview(tableView)
  }
  

  private func setConstraint() {
    let guide = view.safeAreaLayoutGuide
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: guide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
    ])
  }
}

//MARK: -  UITableViewDataSource

extension ViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dominoData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as? MyTableViewCell else {fatalError()}
    cell.configure(data: dominoData[indexPath.row])
    return cell
  }
  
  
}

//MARK: - UITableViewDelegate

extension ViewController : UITableViewDelegate {
  
}
