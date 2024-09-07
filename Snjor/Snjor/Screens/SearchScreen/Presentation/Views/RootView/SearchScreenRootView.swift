//
//  SearchScreenRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

final class SearchScreenRootView: UIView {
  // MARK: Views
  let photosCollectionView: PhotosCollectionView = {
    return $0
  }(PhotosCollectionView())
  
  let albumsCollectionView: TopicsAndAlbumsCollectionView = {
    return $0
  }(TopicsAndAlbumsCollectionView())
  
//  let usersCollectionView: UsersCollectionView = {
//    return $0
//  }(UsersCollectionView())
  
  // MARK: Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
    backgroundColor = .systemBackground
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
