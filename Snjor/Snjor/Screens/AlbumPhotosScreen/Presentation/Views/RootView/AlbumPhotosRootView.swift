//
//  AlbumPhotosRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

fileprivate typealias Const = AlbumPhotosRootViewConst

final class AlbumPhotosRootView: BaseView {
  // MARK: Private Properties
  private var backButtonAction: (() -> Void)?
  
  // MARK: CollectionView
  let albumPhotosCollectionView: AlbumPhotosCollectionView = {
    return $0
  }(AlbumPhotosCollectionView())
  
  // MARK: Button Background View
  let backBarButtonBackgroundView: UIView = {
    $0.frame.size.width = Const.backBarButtonBackgroundViewSize
    $0.frame.size.height = Const.backBarButtonBackgroundViewSize
    $0.layer.cornerRadius = Const.backBarButtonBackgroundViewCircle
    $0.clipsToBounds = true
    $0.backgroundColor = .label
    return $0
  }(UIView())
  
  // MARK: Buttons
  lazy var backBarButton: UIButton = {
    let icon = SFSymbol.backBarButtonIcon
    $0.setImage(icon, for: .normal)
    $0.tintColor = .systemBackground
    $0.frame = backBarButtonBackgroundView.bounds
    return $0
  }(UIButton())
  
  // MARK: Lable
  let albumNameLable: UILabel = {
    $0.font = Const.albumNameTextFont
    $0.widthAnchor.constraint(
      equalToConstant: Const.titleViewWidth
    ).isActive = true
    $0.numberOfLines = .zero
    $0.textAlignment = .center
    return $0
  }(UILabel())
  
  // MARK: VIews
  let titleView: UIView = {
    $0.frame = CGRect(
      x: .zero,
      y: .zero,
      width: Const.titleViewWidth,
      height: Const.titleViewHeight
    )
    return $0
  }(UIView())
  
  // MARK: Initializers
  override func initViews() {
    setupViews()
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(albumPhotosCollectionView)
    backBarButtonBackgroundView.addSubview(backBarButton)
    addSubview(titleView)
    titleView.addSubview(albumNameLable)
  }
  
  private func setupConstraints() {
    albumPhotosCollectionView.fillSuperView()
    albumNameLable.centerXY()
  }
  
  // MARK: Config Navigation Item Actions
  func setupBarButtonItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    setupBackButtonAction(navigationController: navigationController)
    setupBackButtonTarget()
    setupBackBarButton(navigationItem: navigationItem)
  }
  
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
  
  @objc private func backButtonTapped() {
    backButtonAction?()
  }
}
