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
  private var showsUsername = true {
    didSet {
      userNameLabel.alpha = showsUsername ? 1 : 0
      gradientView.alpha = showsUsername ? 1 : 0
    }
  }

  // MARK: - Views
  let photoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  private let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      GradientView.Color(color: .clear, location: 0.7),
      GradientView.Color(color: UIColor(white: 0, alpha: 0.5), location: 1)
    ])
    return $0
  }(GradientView())

  private let userNameLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 13, weight: .medium)
    return $0
  }(UILabel())

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
    photoImageView.image = nil
    userNameLabel.text = nil
    task?.cancel()
  }

  // MARK: - Public Methods
  func configCell(viewModel: PhotoListViewModelItem) {
    setImage(viewModel: viewModel)
  }

  // MARK: - Private Methods
  private func setImage(
    viewModel: PhotoListViewModelItem,
    showsUsername: Bool = true
  ) {
    self.showsUsername = showsUsername
    userNameLabel.text = viewModel.name
    if let cellImageData = viewModel.imageData {
      photoImageView.setImageFromData(data: cellImageData)
    } else {
      task = Task {
        if let blurHash = viewModel.photo.blurHash {

          let size = CGSize(width: 20.0, height: 20.0)
          photoImageView.image = UIImage(blurHash: blurHash, size: size)

          let cellImageData = await viewModel.getImageData()
          photoImageView.setImageFromData(data: cellImageData)

        } else {
          let dataImage = await viewModel.getImageData()
          photoImageView.setImageFromData(data: dataImage)
        }
      }
    }
  }

  private func setupPhotoView() {
    contentView.preservesSuperviewLayoutMargins = true

    contentView.addSubview(photoImageView)
    contentView.addSubview(gradientView)
    contentView.addSubview(userNameLabel)

    setupConstraints()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

      gradientView.topAnchor.constraint(equalTo: contentView.topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      gradientView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

      userNameLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 10),
      userNameLabel.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -10)
    ])
  }
}

// MARK: - Reusable
extension PhotoCell: Reusable { }
