//
//  AlbumPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

protocol AlbumPhotoCellDelegate: AnyObject {
  func downloadTapped(_ cell: AlbumPhotoCell)
}

final class AlbumPhotoCell: UICollectionViewCell {
  
  // MARK: - Delegate
  weak var delegate: (any AlbumPhotoCellDelegate)?

  // MARK: - Main View
  let mainView: AlbumPhotoCellMainView = {
    return $0
  }(AlbumPhotoCellMainView())
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupMainView()
    mainView.delegate = self
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
  func configure(viewModelItem: AlbumPhotosViewModelItem) {
    let photo = viewModelItem.photo
    let photoURL = viewModelItem.photoURL
    mainView.configure(with: photo, url: photoURL)
  }

  // MARK: - Setup Views
  private func setupMainView() {
    contentView.addSubview(mainView)
    mainView.fillSuperView()
  }
}
