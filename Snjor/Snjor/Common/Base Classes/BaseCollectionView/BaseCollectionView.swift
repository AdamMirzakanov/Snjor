//
//  BaseCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 31.08.2024.
//

import UIKit

class BaseCollectionView: UICollectionView {
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
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Internal Methods
  func setupDelegate() { }
  func reusableViewRegister() { }
  func cellRegister() {
    fatalError(ErrorMessage.mustOverrideCellRegister)
  }
  
  func configureLayout() {
    flowlayout.scrollDirection = .vertical
    showsVerticalScrollIndicator = false
  }
}
