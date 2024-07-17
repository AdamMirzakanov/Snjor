//
//  PhotoCell.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol PhotoCellDelegate: AnyObject {
  func downloadTapped(_ cell: PhotoCell)
}

final class PhotoCell: UICollectionViewCell {

  // MARK: - Delegate
  weak var delegate: (any PhotoCellDelegate)?

  // MARK: - Views
  let photoView: PhotoCellView = {
    return $0
  }(PhotoCellView())

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
    photoView.configure(with: photo)
  }

  // MARK: - Setup Views
  private func setupPhotoView() {
    contentView.addSubview(photoView)
    photoView.fillSuperView()
  }
}

// MARK: - Reuse ID
extension PhotoCell: Reusable { }

// MARK: - PhotoCellViewDelegate
extension PhotoCell: PhotoCellViewDelegate {
  func downloadTapped() {
    guard let delegate = delegate else { return }
    delegate.downloadTapped(self)
  }
}
