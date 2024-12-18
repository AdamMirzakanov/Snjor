//
//  SearchResultScreenRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

fileprivate typealias Const = AlbumPhotosRootViewConst

final class SearchResultScreenRootView: UIView {
  // MARK: Private Properties
  private var backButtonAction: (() -> Void)?
  
  // MARK: Views
  let photosCollectionView: SearchResultPhotosCollectionView = {
    return $0
  }(SearchResultPhotosCollectionView())
  
  let albumsCollectionView: SearchResulAlbumsCollectionView = {
    return $0
  }(SearchResulAlbumsCollectionView())
  
  let usersTableViewView: UsersTableView = {
    return $0
  }(UsersTableView())
  
  private let backBarButtonBackgroundView: UIView = {
    $0.frame.size.width = Const.backBarButtonBackgroundViewSize
    $0.frame.size.height = Const.backBarButtonBackgroundViewSize
    $0.layer.cornerRadius = Const.backBarButtonBackgroundViewCircle
    $0.clipsToBounds = true
    $0.backgroundColor = .label
    return $0
  }(UIView())
  
  private lazy var backBarButton: UIButton = {
    let icon = SFSymbol.backBarButtonIcon
    $0.setImage(icon, for: .normal)
    $0.tintColor = .systemBackground
    $0.frame = backBarButtonBackgroundView.bounds
    return $0
  }(UIButton())
  
  // MARK: Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(photosCollectionView)
    addSubview(albumsCollectionView)
    addSubview(usersTableViewView)
    backBarButtonBackgroundView.addSubview(backBarButton)
  }
  
  private func setupConstraints() {
    photosCollectionView.fillSuperView()
    albumsCollectionView.fillSuperView()
    usersTableViewView.fillSuperView()
  }
  
  // MARK: Config Navigation Item Actions
  private func setupBackButtonAction(navigationController: UINavigationController?) {
    backButtonAction = { [weak navigationController] in
      navigationController?.popViewController(animated: true)
    }
  }
  
  private func setupBackButtonTarget() {
    backBarButton.addTarget(
      self,
      action: #selector(backButtonTapped),
      for: .touchUpInside
    )
  }
  
  private func setupBackBarButton(navigationItem: UINavigationItem) {
    let backBarButton = UIBarButtonItem(customView: backBarButtonBackgroundView)
    navigationItem.leftBarButtonItem = backBarButton
  }
  
  func setupBarButtonItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    setupBackButtonAction(navigationController: navigationController)
    setupBackButtonTarget()
    setupBackBarButton(navigationItem: navigationItem)
  }
  
  @objc private func backButtonTapped() {
    backButtonAction?()
  }
}

