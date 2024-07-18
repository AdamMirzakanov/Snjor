//
//  PhotoListCell.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol PhotoListCellDelegate: AnyObject {
  func downloadTapped(_ cell: PhotoListCell)
}

final class PhotoListCell: UICollectionViewCell {
  // MARK: - Delegate
  weak var delegate: (any PhotoListCellDelegate)?

  // MARK: - Main Photo View
  let photoView: PhotoListCellView = {
    return $0
  }(PhotoListCellView())

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPhotoView()
    photoView.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    photoView.prepareForReuse()
  }

  // MARK: - Setup Data
  func configure(with photo: Photo) {
    photoView.configure(with: photo, url: photo.regularURL)
  }

  // MARK: - Setup Views
  private func setupPhotoView() {
    contentView.addSubview(photoView)
    photoView.fillSuperView()
  }
}
