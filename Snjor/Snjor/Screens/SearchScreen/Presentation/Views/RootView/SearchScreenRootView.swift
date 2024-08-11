//
//  SearchScreenRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

class SearchScreenRootView: UIView {
  
  // MARK: - Views
  let photoListCollectionView: PhotosCollectionView = {
    return $0
  }(PhotosCollectionView())
  
  let albumsCollectionView: AlbumsCollectionView = {
    return $0
  }(AlbumsCollectionView())
  
  let usersContainerView: UsersContainerView = {
    return $0
  }(UsersContainerView())
  
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
    addSubview(photoListCollectionView)
    addSubview(albumsCollectionView)
  }
  
  private func setupConstraints() {
    setupPhotoListContainerViewConstraints()
    setupTopicContainerViewConstraints()
    setupUsersContainerViewConstraints()
  }
  
  private func setupPhotoListContainerViewConstraints() {
    photoListCollectionView.fillSuperView()
  }
  
  private func setupTopicContainerViewConstraints() {
    albumsCollectionView.fillSuperView()
  }
  
  private func setupUsersContainerViewConstraints() {
    usersContainerView.fillSuperView()
  }
}
