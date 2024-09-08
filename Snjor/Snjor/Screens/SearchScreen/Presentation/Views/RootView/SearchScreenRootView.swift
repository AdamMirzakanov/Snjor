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
  
  let usersTableViewView: UITableView = {
    $0.register(
      UserTableViewCell.self,
      forCellReuseIdentifier: UserTableViewCell.reuseID
    )
    return $0
  }(UITableView())
  
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
