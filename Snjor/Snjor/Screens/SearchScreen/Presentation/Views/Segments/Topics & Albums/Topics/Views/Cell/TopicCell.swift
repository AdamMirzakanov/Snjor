//
//  TopicCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import UIKit

final class TopicCell: UICollectionViewCell {
  // MARK: Views
  let mainView: TopicCellMainView = {
    return $0
  }(TopicCellMainView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupMainView()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    mainView.prepareForReuse()
  }
  
  // MARK: Setup Data
  func configure(viewModelItem: BaseViewModelItem<Topic>) {
    let topic = viewModelItem.item
    let coverPhotoURL = viewModelItem.photoURL
    mainView.configure(with: topic, url: coverPhotoURL)
  }
  
  // MARK: Setup Views
  private func setupMainView() {
    contentView.addSubview(mainView)
    mainView.fillSuperView()
  }
}
