//
//  MainCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 31.08.2024.
//

import UIKit

class MainCollectionView: UICollectionView {

  // MARK: Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    configureLayout()
    cellRegister()
    reusableViewRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Internal Methods
  func cellRegister() {

  }
  
  func reusableViewRegister() {
    
  }
  
  // MARK: Private Methods
  private func configureLayout() {
    flowlayout.scrollDirection = .vertical
    showsVerticalScrollIndicator = false
  }
}
