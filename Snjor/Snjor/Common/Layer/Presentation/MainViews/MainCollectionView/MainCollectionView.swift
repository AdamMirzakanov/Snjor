//
//  MainCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 31.08.2024.
//

import UIKit

class MainCollectionView: UICollectionView {
  // MARK: Private Properties
  var flowlayout = UICollectionViewFlowLayout()
  
  // MARK: Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    configureLayout()
    cellRegister()
    reusableViewRegister()
    setupDelegate()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Internal Methods
  func cellRegister() { }
  func reusableViewRegister() { }
  func setupDelegate() { }
  
  func configureLayout() {
    flowlayout.scrollDirection = .vertical
    showsVerticalScrollIndicator = false
  }
}
