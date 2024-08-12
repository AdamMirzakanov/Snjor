//
//  AlbumCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

class AlbumCell: UICollectionViewCell {
  
  // MARK: - Main View
  let mainView: AlbumCellMainView = {
    return $0
  }(AlbumCellMainView())
  
  let tagsCollectionView: TagsCollectionView = {
    $0.heightAnchor.constraint(equalToConstant: 22).isActive = true
    return $0
  }(TagsCollectionView())
  
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
}
