//
//  AlbumListCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

class AlbumListCell: UICollectionViewCell {
  
  // MARK: - Main View
  let mainView: AlbumListCellMainView = {
    return $0
  }(AlbumListCellMainView())
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupMainView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    mainView.prepareForReuse()
  }
  
  // MARK: - Setup Data
  func configure(viewModelItem: AlbumsViewModelItem) {
    let album = viewModelItem.album
    let coverPhotoURL = viewModelItem.coverPhoto
    mainView.configure(with: album, url: coverPhotoURL)
  }
  
  // MARK: - Setup Views
  private func setupMainView() {
    contentView.addSubview(mainView)
    mainView.fillSuperView()
  }
}
