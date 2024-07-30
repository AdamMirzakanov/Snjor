//
//  PhotoListCell.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol PhotoCellDelegate: AnyObject {
  func downloadTapped(_ cell: PhotoListCell)
}

final class PhotoListCell: UICollectionViewCell {
  // MARK: - Delegate
  weak var delegate: (any PhotoCellDelegate)?

  // MARK: - Main View
  let mainView: PhotoListCellMainView = {
    return $0
  }(PhotoListCellMainView())

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPhotoView()
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
  func configure(viewModelItem: PhotoListViewModelItem) {
    let photo = viewModelItem.photo
    let photoURL = viewModelItem.photoURL
    mainView.configure(with: photo, url: photoURL)
  }

  // MARK: - Setup Views
  private func setupPhotoView() {
    contentView.addSubview(mainView)
    mainView.fillSuperView()
  }
}
