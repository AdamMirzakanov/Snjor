//
//  SecondCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class SecondCell: BaseColletionViewCell<SecondCellRootView> {
  // MARK: Internal Properties
  var userPhotosSections: [UserPhotosSection] = []
  var userPhotosDataSource: UserPhotosDataSource?
  var userPhotosViewModel: (any ContentManagingProtocol<Photo>)?
  weak var delegate: (any SecondCellDelegate)?
  
  // MARK: Initializers
  override func initCell() {
    super.initCell()
    setupLayout()
    createPhotosDataSource(for: rootView.userPhotosCollectionView)
    setupCollectionViewDelegate()
  }
  
  // MARK: Internal Methods
  func configure(with viewModel: any ContentManagingProtocol<Photo>) {
    self.userPhotosViewModel = viewModel
    applyPhotosSnapshot()
  }
  
  // MARK: Private Methods
  private func setupLayout() {
    let cascadeLayout = UserPhotosCascadeLayout(with: self)
    rootView.userPhotosCollectionView.collectionViewLayout = cascadeLayout
    rootView.userPhotosCollectionView.frame = contentView.bounds
  }
  
  private func setupCollectionViewDelegate() {
    rootView.userPhotosCollectionView.userPhotosDelegate = self
  }
}
