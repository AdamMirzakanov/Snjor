//
//  SecondCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class SecondCell: UICollectionViewCell {
  // MARK: Internal Properties
  var userPhotosSections: [UserPhotosSection] = []
  var userPhotosDataSource: UserPhotosDataSource?
  var userPhotosViewModel: (any ContentManagingProtocol<Photo>)?
  weak var delegate: (any SecondCellDelegate)?
  
  // MARK: Views
  lazy var noPhotosStackView: UIStackView = {
    $0.alpha = Const.bigIconOpacity
    $0.isUserInteractionEnabled = false
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(noPhotoImageView)
    $0.addArrangedSubview(noPhotosLabel)
    return $0
  }(UIStackView())
  
  private let noPhotoImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .photoCircleIcon)
    $0.tintColor = .systemOrange
    $0.heightAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let noPhotosLabel: UILabel = {
    $0.text = .noPhotos
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: Const.bigIconFontName,
      size: Const.bigIconFontSize
    )
    return $0
  }(UILabel())
  
  let userPhotosCollectionView: UserPhotosCollectionView = {
    $0.backgroundColor = .black
    return $0
  }(UserPhotosCollectionView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
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
    contentView.addSubview(noPhotosStackView)
  }
  
  private func setupConstraints() {
    noPhotosStackView.setConstraints(
      centerY: centerYAnchor,
      centerX: centerXAnchor,
      pCenterY: Const.stackViewCenterYOffset
    )
  }
  
  private func setupLayout() {
    let cascadeLayout = UserPhotosCascadeLayout(with: self)
    userPhotosCollectionView.collectionViewLayout = cascadeLayout
    userPhotosCollectionView.frame = contentView.bounds
  }
  
  private func setupCollectionViewDelegate() {
    userPhotosCollectionView.userPhotosDelegate = self
  }
}

