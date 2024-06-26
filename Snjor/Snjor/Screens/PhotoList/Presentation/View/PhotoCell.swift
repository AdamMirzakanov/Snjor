//
//  PhotoCell.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  // MARK: - Private Properties
  private var task: Task<Void, Never>?

  // MARK: - Views
  let photoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

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
    task?.cancel()
    photoImageView.image = nil
  }

  // MARK: - Public Methods
  func configCell(viewModel: PhotoListViewModelItem) {
    setImage(viewModel: viewModel)
  }

  func setImage(viewModel: PhotoListViewModelItem) {
    if let data = viewModel.imageDataFromCache {
      photoImageView.setImageFromData(data: data)
      print("из Кэша")
    } else {
      task = Task {
        if let blurHash = viewModel.photo.blurHash {
          let size = CGSize(width: 20.0, height: 20.0)
          photoImageView.image = UIImage(blurHash: blurHash, size: size)
          let dataImage = await viewModel.getImageData()
          photoImageView.setImageFromData(data: dataImage)
          print("из Интернета + БлюрХэш")
        } else {
          let dataImage = await viewModel.getImageData()
          photoImageView.setImageFromData(data: dataImage)
          print("из Интернета без БлюрХэша")
        }
      }
    }
  }

  // MARK: - Private Methods
  private func setupPhotoView() {
    contentView.preservesSuperviewLayoutMargins = true
    contentView.addSubview(photoImageView)
    setupConstraints()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
}

// MARK: - Reusable
extension PhotoCell: Reusable { }
