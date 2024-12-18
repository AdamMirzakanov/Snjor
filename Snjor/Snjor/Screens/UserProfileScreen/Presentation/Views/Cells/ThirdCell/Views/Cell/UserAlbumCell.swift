//
//  UserAlbumCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.09.2024.
//

import UIKit

final class UserAlbumCell: UICollectionViewCell {
  // MARK: Views
  let mainView: AlbumCellMainView = {
    return $0
  }(AlbumCellMainView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    mainView.prepareForReuse()
  }
  
  // MARK: Setup Data
  func configure(viewModelItem: BaseViewModelItem<Album> ) {
    let album = viewModelItem.item
    let coverPhotoURL = viewModelItem.photoURL
    mainView.configure(with: album, url: coverPhotoURL)
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    contentView.addSubview(mainView)
  }
  
  private func setupConstraints() {
    mainView.fillSuperView()
  }
}
