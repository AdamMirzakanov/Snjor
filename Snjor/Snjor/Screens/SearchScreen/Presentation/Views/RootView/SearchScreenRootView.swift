//
//  SearchScreenRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

final class SearchScreenRootView: BaseView {
  // MARK: Views
  let photosCollectionView: SearchScreenPhotosCollectionView = {
    return $0
  }(SearchScreenPhotosCollectionView())
  
  let topicsAndAlbumsCollectionView: TopicsAndAlbumsCollectionView = {
    return $0
  }(TopicsAndAlbumsCollectionView())
  
  let usersTableViewView: UsersTableView = {
    return $0
  }(UsersTableView())
  
  // MARK: Initializers
  override func initViews() {
    setupViews()
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
    backgroundColor = .systemBackground
  }
  
  private func addSubviews() {
    addSubview(photosCollectionView)
    addSubview(topicsAndAlbumsCollectionView)
    addSubview(usersTableViewView)
  }
  
  private func setupConstraints() {
    photosCollectionView.fillSuperView()
    topicsAndAlbumsCollectionView.fillSuperView()
    usersTableViewView.fillSuperView()
  }
}
