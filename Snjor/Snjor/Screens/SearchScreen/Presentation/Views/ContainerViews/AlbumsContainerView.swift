//
//  AlbumsContainerView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

class AlbumsContainerView: UIView {
  let albumsCollectionView: AlbumsCollectionView = {
    return $0
  }(AlbumsCollectionView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(albumsCollectionView)
  }
  
  private func setupConstraints() {
    photoListCollectionViewConstraints()
  }
  
  private func photoListCollectionViewConstraints() {
    albumsCollectionView.fillSuperView()
  }
}

final class AlbumsCollectionView: UICollectionView {
  // MARK: - Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    configureLayout()
    cellRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  private func configureLayout() {
    flowlayout.scrollDirection = .vertical
    backgroundColor = .clear
    showsHorizontalScrollIndicator = false
  }
  
  private func cellRegister() {
    register(
      AlbumListCell.self,
      forCellWithReuseIdentifier: AlbumListCell.reuseID
    )
  }
}
