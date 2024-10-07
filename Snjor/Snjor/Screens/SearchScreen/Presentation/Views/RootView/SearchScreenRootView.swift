//
//  SearchScreenRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

final class SearchScreenRootView: UIView {
  // MARK: Views
  let photosCollectionView: SearchScreenPhotosCollectionView = {
    return $0
  }(SearchScreenPhotosCollectionView())
  
  let albumsCollectionView: TopicsAndAlbumsCollectionView = {
    return $0
  }(TopicsAndAlbumsCollectionView())
  
  let usersTableViewView: UsersTableView = {
    return $0
  }(UsersTableView())
  
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
    addSubview(usersTableViewView)
  }
  
  private func setupConstraints() {
    photosCollectionView.fillSuperView()
    albumsCollectionView.fillSuperView()
    usersTableViewView.fillSuperView()
  }
}
