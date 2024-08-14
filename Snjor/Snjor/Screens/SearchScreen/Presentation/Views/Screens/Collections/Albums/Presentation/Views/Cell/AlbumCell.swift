//
//  AlbumCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

class AlbumCell: UICollectionViewCell {
  
  // MARK: - Views
  let mainView: AlbumCellMainView = {
    return $0
  }(AlbumCellMainView())
  
  let tagsCollectionView: TagsCollectionView = {
    $0.heightAnchor.constraint(equalToConstant: 22).isActive = true
    return $0
  }(TagsCollectionView())
  
  private let rightGradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.isUserInteractionEnabled = false
    return $0
  }(GradientView())
  
  private let leftGradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.isUserInteractionEnabled = false
    return $0
  }(GradientView())
  
  lazy var mainViewAndTagsCollectionStackView: UIStackView = {
    $0.axis = .vertical
    $0.addArrangedSubview(mainView)
    $0.addArrangedSubview(tagsCollectionView)
    $0.spacing = 10
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupMainView()
    addSubview(rightGradientView)
    addSubview(leftGradientView)
    NSLayoutConstraint.activate([
      rightGradientView.trailingAnchor.constraint(equalTo: tagsCollectionView.trailingAnchor),
      rightGradientView.topAnchor.constraint(equalTo: tagsCollectionView.topAnchor),
      rightGradientView.bottomAnchor.constraint(equalTo: tagsCollectionView.bottomAnchor),
      rightGradientView.widthAnchor.constraint(equalToConstant: 22)
    ])
    rightGradientView.transform = CGAffineTransform(rotationAngle: .pi / 2)
    
    NSLayoutConstraint.activate([
      leftGradientView.leadingAnchor.constraint(equalTo: tagsCollectionView.leadingAnchor),
      leftGradientView.topAnchor.constraint(equalTo: tagsCollectionView.topAnchor),
      leftGradientView.bottomAnchor.constraint(equalTo: tagsCollectionView.bottomAnchor),
      leftGradientView.widthAnchor.constraint(equalToConstant: 22)
    ])
    leftGradientView.transform = CGAffineTransform(rotationAngle: .pi * 1.5)
    
    updateGradientColors()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    mainView.prepareForReuse()
    tagsCollectionView.tags = []
    tagsCollectionView.reloadData()
  }
  
  // MARK: - Setup Data
  func configure(viewModelItem: AlbumsViewModelItem) {
    let album = viewModelItem.album
    let coverPhotoURL = viewModelItem.coverPhoto
    mainView.configure(with: album, url: coverPhotoURL)
    tagsCollectionView.tags = album.tags ?? []
    tagsCollectionView.reloadData()
  }
  
  // MARK: - Setup Views
  private func setupMainView() {
    contentView.addSubview(mainViewAndTagsCollectionStackView)
    mainViewAndTagsCollectionStackView.fillSuperView()
  }
  
  // MARK: - Update Gradient Colors
  private func updateGradientColors() {
    rightGradientView.setColors([
      GradientView.Color(
        color: UIColor.systemBackground.withAlphaComponent(1.0),
        location: 0.1
      ),
      GradientView.Color(
        color: UIColor.systemBackground.withAlphaComponent(0.0),
        location: 0.6
      ),
    ])
    
    leftGradientView.setColors([
      GradientView.Color(
        color: UIColor.systemBackground.withAlphaComponent(1.0),
        location: 0.1
      ),
      GradientView.Color(
        color: UIColor.systemBackground.withAlphaComponent(0.0),
        location: 0.6
      ),
    ])
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
      updateGradientColors()
    }
  }
}

