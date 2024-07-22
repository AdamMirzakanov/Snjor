//
//  TopicsPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import UIKit

protocol TopicsPhotosCellDelegate: AnyObject {
  func downloadTapped(_ cell: TopicsPhotoCell)
}

final class TopicsPhotoCell: UICollectionViewCell {
  
  // MARK: - Delegate
  weak var delegate: (any TopicsPhotoCellDelegate)?
  
  // MARK: - Main Photo View
  let photoView: PhotoCellPhotoView = {
    return $0
  }(PhotoCellPhotoView())
  
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
