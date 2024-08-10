//
//  SearchScreenRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit

class SearchScreenRootView: UIView {
  
  // MARK: - Views
  let photoListContainerView: UIView = {
    return $0
  }(UIView())
  
  let albumListContainerView: UIView = {
    return $0
  }(UIView())
  
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
    addSubview(photoListContainerView)
    addSubview(albumListContainerView)
    addSubview(usersContainerView)
  }
  
  private func setupConstraints() {
    setupPhotoListContainerViewConstraints()
    setupTopicContainerViewConstraints()
    setupUsersContainerViewConstraints()
  }
  
  private func setupPhotoListContainerViewConstraints() {
    photoListContainerView.fillSuperView()
  }
  
  private func setupTopicContainerViewConstraints() {
    albumListContainerView.fillSuperView()
  }
  
  private func setupUsersContainerViewConstraints() {
    usersContainerView.fillSuperView()
  }
}
