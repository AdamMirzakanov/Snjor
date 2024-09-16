//
//  FirstCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

final class FirstCell: UICollectionViewCell {
  // MARK: Internal Properties
  var userLikedPhotosSections: [UserLikedPhotosSection] = []
  var userLikedPhotosDataSource: UserLikedPhotosDataSource?
  var userLikedPhotosViewModel: (any ContentManagingProtocol<Photo>)?
  
  // MARK: Views
  private let userLikedPhotosCollectionView: UserLikedPhotosCollectionView = {
    return $0
  }(UserLikedPhotosCollectionView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupLayout()
    createPhotosDataSource(for: userLikedPhotosCollectionView)
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Internal Methods
  func configure(with viewModel: any ContentManagingProtocol<Photo>) {
    self.userLikedPhotosViewModel = viewModel
    applyPhotosSnapshot()
  }
  
  // MARK: Private Methods
  private func setupViews() {
    contentView.addSubview(userLikedPhotosCollectionView)
    userLikedPhotosCollectionView.frame = contentView.bounds
  }
  
  private func setupLayout() {
    let cascadeLayout = MultiColumnCascadeLayout(with: self)
    userLikedPhotosCollectionView.collectionViewLayout = cascadeLayout
  }
}
