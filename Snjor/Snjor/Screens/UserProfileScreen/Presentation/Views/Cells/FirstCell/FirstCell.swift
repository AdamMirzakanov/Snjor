//
//  FirstCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

final class FirstCell: UICollectionViewCell {
  // MARK: Internal Properties
  var userLikedPhotosSections: [UserLikedPhotosSection] = []
  var userLikedPhotosDataSource: UserLikedPhotosDataSource?
  var userLikedPhotosViewModel: (any ContentManagingProtocol<Photo>)?
  weak var delegate: (any FirstCellDelegate)?
  
  // MARK: Views
  private let noLikedPhotosLabel: UILabel = {
    $0.text = .noLikes
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: Const.bigIconFontName,
      size: Const.bigIconFontSize
    )
    return $0
  }(UILabel())
  
  private let noLikedImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = SFSymbol.heartCircleIcon
    $0.tintColor = .systemPink
    $0.heightAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  lazy var noLikedPhotosStackView: UIStackView = {
    $0.alpha = Const.bigIconOpacity
    $0.isUserInteractionEnabled = false
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(noLikedImageView)
    $0.addArrangedSubview(noLikedPhotosLabel)
    return $0
  }(UIStackView())
  
  let userLikedPhotosCollectionView: UserLikedPhotosCollectionView = {
    $0.backgroundColor = .black
    return $0
  }(UserLikedPhotosCollectionView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    setupLayout()
    createPhotosDataSource(for: userLikedPhotosCollectionView)
    setupCollectionViewDelegate()
  }
  
  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
  
  // MARK: Internal Methods
  func configure(with viewModel: any ContentManagingProtocol<Photo>) {
    self.userLikedPhotosViewModel = viewModel
    applyPhotosSnapshot()
  }
  
  // MARK: Private Methods
  private func setupViews() {
    contentView.addSubview(userLikedPhotosCollectionView)
    contentView.addSubview(noLikedPhotosStackView)
  }
  
  private func setupConstraints() {
    noLikedPhotosStackView.setConstraints(
      centerY: centerYAnchor,
      centerX: centerXAnchor,
      pCenterY: Const.stackViewCenterYOffset
    )
  }
  
  private func setupLayout() {
    let cascadeLayout = UserPhotosCascadeLayout(with: self)
    userLikedPhotosCollectionView.collectionViewLayout = cascadeLayout
    userLikedPhotosCollectionView.frame = contentView.bounds
  }
  
  private func setupCollectionViewDelegate() {
    userLikedPhotosCollectionView.likedPhotosDelegate = self
  }
}
