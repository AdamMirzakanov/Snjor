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

  // MARK: - Internal Properties
  weak var delegate: (any PhotoCellDelegate)?

  // MARK: - Views
  private let photoView: PhotoCellView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(PhotoCellView())

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
  func configure(with photo: Photo) {
    photoView.configure(with: photo)
  }

  // MARK: - Private Methods
  private func setupPhotoView() {
    contentView.addSubview(photoView)
    photoView.fillSuperView()
    photoView.setupBaseViews()
    photoView.setupDownloadButton()
  }

  private func configDownloadButtonAction() {
    let downloadButtonAction = downloadAction()
    addAction(downloadButtonAction)
  }

  private func downloadAction() -> UIAction {
    return UIAction { [weak self] _ in
      guard
        let self = self,
        let delegate = delegate
      else {
        return
      }
      animateButton()
      delegate.downloadTapped(self)
    }
  }

  private func addAction(_ action: UIAction) {
    photoView.downloadButton.addAction(
      action,
      for: .touchUpInside
    )
  }

  private func animateButton() {
    UIView.animate(withDuration: PhotoCellConst.duration) {
      let scaleTransform = CGAffineTransform(scaleX: PhotoCellConst.scale, y: PhotoCellConst.scale)
      self.photoView.blurEffect.transform = scaleTransform
    } completion: { _ in
      UIView.animate(withDuration: PhotoCellConst.duration) {
        self.photoView.blurEffect.transform = CGAffineTransform.identity
      }
    }
  }
}

// MARK: - Reusable
extension PhotoCell: Reusable { }
