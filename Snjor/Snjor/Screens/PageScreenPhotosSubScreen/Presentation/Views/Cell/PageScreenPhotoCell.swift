//
//  PageScreenPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 30.07.2024.
//

import UIKit

final class PageScreenPhotoCell: UICollectionViewCell {
  // MARK: Views
  private let mainView: PageScreenPhotoCellMainView = {
    return $0
  }(PageScreenPhotoCellMainView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPhotoView()
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
  func configure(viewModelItem: BaseViewModelItem<Photo>) {
    let photo = viewModelItem.item
    let photoURL = viewModelItem.photoURL
    mainView.configure(with: photo, url: photoURL)
  }

  // MARK: Setup Views
  private func setupPhotoView() {
    contentView.addSubview(mainView)
    mainView.fillSuperView()
  }
}
