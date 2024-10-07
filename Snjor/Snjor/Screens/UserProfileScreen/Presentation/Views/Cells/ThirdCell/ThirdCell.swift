//
//  ThirdCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerRootViewConst

class ThirdCell: UICollectionViewCell {
  // MARK: Internal Properties
  var userAlbumsSections: [UserAlbumsSection] = []
  var userAlbumsDataSource: UserAlbumsDataSource?
  var userAlbumsViewModel: (any ContentManagingProtocol<Album>)?
  weak var delegate: (any ThirdCellDelegate)?
  
  // MARK: Private Properties
  private let layoutFactory = UserAlbumsLayoutFactory()
  
  // MARK: Views
  lazy var noAlbumsStackView: UIStackView = {
    $0.alpha = Const.bigIconOpacity
    $0.isUserInteractionEnabled = false
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = Const.stackViewSpacing
    $0.addArrangedSubview(noAlbumImageView)
    $0.addArrangedSubview(noAlbumsLabel)
    return $0
  }(UIStackView())
  
  private let noAlbumImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .macroCircleIcon)
    $0.tintColor = .systemGreen
    $0.heightAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    $0.widthAnchor.constraint(
      equalToConstant: Const.bigIconSize
    ).isActive = true
    return $0
  }(UIImageView())
  
  private let noAlbumsLabel: UILabel = {
    $0.text = .noAlbums
    $0.textColor = .white
    $0.textAlignment = .center
    $0.numberOfLines = .zero
    $0.font = UIFont(
      name: Const.bigIconFontName,
      size: Const.bigIconFontSize
    )
    return $0
  }(UILabel())
  
  let userAlbumsCollectionView: UserAlbumsCollectionView = {
    $0.backgroundColor = .black
    return $0
  }(UserAlbumsCollectionView())
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    setupLayout()
    createAlbumsDataSource(for: userAlbumsCollectionView)
    setupCollectionViewDelegate()
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Internal Methods
  func configure(with viewModel: any ContentManagingProtocol<Album>) {
    self.userAlbumsViewModel = viewModel
    applyAlbumsSnapshot()
  }
  
  // MARK: Private Methods
  private func setupViews() {
    contentView.addSubview(userAlbumsCollectionView)
    contentView.addSubview(noAlbumsStackView)
  }
  
  private func setupConstraints() {
    noAlbumsStackView.setConstraints(
      centerY: centerYAnchor,
      centerX: centerXAnchor,
      pCenterY: Const.stackViewCenterYOffset
    )
  }
  
  private func setupLayout() {
    let layout = layoutFactory.createAlbumsLayout()
    userAlbumsCollectionView.collectionViewLayout = layout
    userAlbumsCollectionView.frame = contentView.bounds
  }
  
  private func setupCollectionViewDelegate() {
    userAlbumsCollectionView.userAlbumsDelegate = self
  }
}
