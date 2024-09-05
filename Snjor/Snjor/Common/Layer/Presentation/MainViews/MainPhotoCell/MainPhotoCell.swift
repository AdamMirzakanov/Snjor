//
//  MainPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 31.08.2024.
//

import UIKit

class MainPhotoCell: UICollectionViewCell {

  // MARK: Main View
  let mainView: PhotoCellMainView = {
    return $0
  }(PhotoCellMainView())

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
  func configure(viewModelItem: BaseViewModelItem <Photo>) {
    let photo = viewModelItem.item
    let photoURL = viewModelItem.photoURL
    mainView.configure(with: photo, url: photoURL)
  }

  // MARK: Setup Views
  private func setupMainView() {
    contentView.addSubview(mainView)
    mainView.fillSuperView()
  }
}
