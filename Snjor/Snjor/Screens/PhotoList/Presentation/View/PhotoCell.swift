//
//  PhotoCell.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

protocol PhotoCellDelegate: AnyObject {
  func cancelTapped(_ cell: PhotoCell)
  func downloadTapped(_ cell: PhotoCell)
  func pauseTapped(_ cell: PhotoCell)
  func resumeTapped(_ cell: PhotoCell)
}

class PhotoCell: UICollectionViewCell {
  
  // MARK: - Internal Properties
  weak var delegate: (any PhotoCellDelegate)?

  // MARK: - Views
  private let photoView: PhotoListView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(PhotoListView())

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPhotoView()
    configDownloadButtonAction()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    photoView.prepareForReuse()
  }

  // MARK: - Internal Methods
  func configure(with photo: Photo, downloaded: Bool, download: Download?) {
    photoView.configure(with: photo)
    if let download = download {
      let imageName = download.isDownloading ? "pause.circle.fill" : "play.circle.fill"
      photoView.downloadBarButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
  }

  // MARK: - Private Methods
  private func setupPhotoView() {
    contentView.preservesSuperviewLayoutMargins = true
    contentView.addSubview(photoView)
    photoView.setupImageView()
    photoView.setupDownloadButton()
    setupConstraints()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
      photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
  private func configDownloadButtonAction() {
    let downloadButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      UIView.animate(withDuration: 0.15) {
        self.photoView.downloadBarButtonBlurView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      } completion: { _ in
        UIView.animate(withDuration: 0.15) {
          self.photoView.downloadBarButtonBlurView.transform = CGAffineTransform.identity
        }
      }

      delegate?.downloadTapped(self)
    }
    photoView.downloadBarButton.addAction(
      downloadButtonAction,
      for: .touchUpInside
    )
  }
}

// MARK: - Reusable
extension PhotoCell: Reusable { }
