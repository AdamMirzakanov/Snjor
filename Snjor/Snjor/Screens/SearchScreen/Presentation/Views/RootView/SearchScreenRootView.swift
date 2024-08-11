//
//  SearchScreenRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

class SearchScreenRootView: UIView {
  
  // MARK: - Collection Views
  let photosCollectionView: PhotosCollectionView = {
    return $0
  }(PhotosCollectionView())
  
  let albumsCollectionView: AlbumsCollectionView = {
    return $0
  }(AlbumsCollectionView())
  
//  let usersCollectionView: UsersCollectionView = {
//    return $0
//  }(UsersCollectionView())
  
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
    addSubview(photosCollectionView)
    addSubview(albumsCollectionView)
  }
  
  private func setupConstraints() {
    photosCollectionView.fillSuperView()
    albumsCollectionView.fillSuperView()
//    usersCollectionView.fillSuperView()
  }
}
