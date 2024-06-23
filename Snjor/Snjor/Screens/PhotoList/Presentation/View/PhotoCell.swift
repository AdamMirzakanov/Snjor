//
//  PhotoCell.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  // MARK: - Private Properties
  private let photoView: PhotoViewSmallQuality = {
    let photoView = PhotoViewSmallQuality()
    photoView.translatesAutoresizingMaskIntoConstraints = false
    return photoView
  }()

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPhotoView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    photoView.prepareForReuse()
  }

  // MARK: - Public Methods
  func configure(with photo: Photo) {
    photoView.configure(with: photo)
  }

  // MARK: - Private Methods
  private func setupPhotoView() {
    contentView.preservesSuperviewLayoutMargins = true
    contentView.addSubview(photoView)
    setupConstraints()
    photoView.setupImageView()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
      photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
}

// MARK: - Reusable
extension PhotoCell: Reusable { }
