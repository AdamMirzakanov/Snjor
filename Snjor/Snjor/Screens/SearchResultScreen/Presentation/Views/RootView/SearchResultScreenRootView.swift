//
//  SearchResultScreenRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import UIKit

final class SearchResultScreenRootView: UIView {
  
  // MARK: Views
  let photosCollectionView: PhotosCollectionView = {
    return $0
  }(PhotosCollectionView())
  
  let albumsCollectionView: AlbumsCollectionView = {
    return $0
  }(AlbumsCollectionView())
  
  private let backBarButtonBackgroundView: UIView = {
    $0.frame.size.width = AlbumPhotosRootViewConst.backBarButtonBackgroundViewSize
    $0.frame.size.height = AlbumPhotosRootViewConst.backBarButtonBackgroundViewSize
    $0.layer.cornerRadius = AlbumPhotosRootViewConst.backBarButtonBackgroundViewCircle
    $0.clipsToBounds = true
    $0.backgroundColor = .label
    return $0
  }(UIView())
  
  private lazy var backBarButton: UIButton = {
    let icon = UIImage(systemName: .backBarButtonImage)
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
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(photosCollectionView)
    addSubview(albumsCollectionView)
    backBarButtonBackgroundView.addSubview(backBarButton)
  }
  
  private func setupConstraints() {
    photosCollectionView.fillSuperView()
    albumsCollectionView.fillSuperView()
  }
  
  func setupBarButtonItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    setupNavigationItems(navigationItem)
    configBackButtonAction(navigationController)
  }
  
  // MARK: Config Navigation Item Actions
  private func configBackButtonAction(
    _ navigationController: UINavigationController?
  ) {
    let backButtonAction = UIAction { _ in
      navigationController?.popViewController(animated: true)
    }
    backBarButton.addAction(
      backButtonAction,
      for: .touchUpInside
    )
  }
  
  private func setupNavigationItems(_ navigationItem: UINavigationItem) {
    navigationItem.leftBarButtonItem = makeLeftBarButtons()
  }
  
  private func makeLeftBarButtons() -> UIBarButtonItem {
    let backBarButton = UIBarButtonItem(customView: backBarButtonBackgroundView)
    return backBarButton
  }
}

