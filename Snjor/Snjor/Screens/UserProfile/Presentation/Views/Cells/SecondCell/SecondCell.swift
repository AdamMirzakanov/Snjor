//
//  SecondCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

final class SecondCell: UICollectionViewCell {
  // MARK: Internal Properties
  var userPhotosSections: [UserPhotosSection] = []
  var userPhotosDataSource: UserPhotosDataSource?
  var userPhotosViewModel: (any ContentManagingProtocol<Photo>)?
  
  // MARK: Views
  private let userPhotosCollectionView: UserPhotosCollectionView = {
    return $0
  }(UserPhotosCollectionView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupLayout()
    createPhotosDataSource(for: userPhotosCollectionView)
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Internal Methods
  func configure(with viewModel: any ContentManagingProtocol<Photo>) {
    self.userPhotosViewModel = viewModel
    applyPhotosSnapshot()
  }
  
  // MARK: Private Methods
  private func setupViews() {
    contentView.addSubview(userPhotosCollectionView)
    userPhotosCollectionView.frame = contentView.bounds
  }
  
  private func setupLayout() {
    let cascadeLayout = UserProfileCascadeLayout(with: self)
    userPhotosCollectionView.collectionViewLayout = cascadeLayout
  }
}

