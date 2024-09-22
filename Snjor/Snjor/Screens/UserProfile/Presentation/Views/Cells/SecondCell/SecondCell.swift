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
  weak var delegate: (any SecondCellDelegate)?
  
  // MARK: Views
  private let userPhotosCollectionView: UserPhotosCollectionView = {
    $0.backgroundColor = .black
    return $0
  }(UserPhotosCollectionView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupLayout()
    createPhotosDataSource(for: userPhotosCollectionView)
    setupCollectionViewDelegate()
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
    let cascadeLayout = UserPhotosCascadeLayout(with: self)
    userPhotosCollectionView.collectionViewLayout = cascadeLayout
  }
  
  private func setupCollectionViewDelegate() {
    userPhotosCollectionView.userPhotosDelegate = self
  }
}

