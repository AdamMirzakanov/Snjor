//
//  AlbumPhotosRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.08.2024.
//

import UIKit

final class AlbumPhotosRootView: UIView {
  
  // MARK: Private Properties
  private var backButtonAction: (() -> Void)?
  
  // MARK: CollectionView
  let albumPhotosCollectionView: AlbumPhotosCollectionView = {
    return $0
  }(AlbumPhotosCollectionView())
  
  // MARK: Button Background View
   let backBarButtonBackgroundView: UIView = {
    $0.frame.size.width = AlbumPhotosRootViewConst.backBarButtonBackgroundViewSize
    $0.frame.size.height = AlbumPhotosRootViewConst.backBarButtonBackgroundViewSize
    $0.layer.cornerRadius = AlbumPhotosRootViewConst.backBarButtonBackgroundViewCircle
    $0.clipsToBounds = true
    $0.backgroundColor = .label
    return $0
  }(UIView())
  
  // MARK: Buttons
   lazy var backBarButton: UIButton = {
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
    addSubview(albumPhotosCollectionView)
    backBarButtonBackgroundView.addSubview(backBarButton)
  }
  
  private func setupConstraints() {
    albumPhotosCollectionView.fillSuperView()
  }
  
  func setupBarButtonItems(
    navigationItem: UINavigationItem,
    navigationController: UINavigationController?
  ) {
    
    backButtonAction = { [weak navigationController] in
      navigationController?.popViewController(animated: true)
    }
    
    backBarButton.addTarget(
      self,
      action: #selector(backButtonTapped),
      for: .touchUpInside
    )
    
    let backBarButton = UIBarButtonItem(customView: backBarButtonBackgroundView)
    navigationItem.leftBarButtonItem = backBarButton
  }
  
  @objc private func backButtonTapped() {
    backButtonAction?()
  }
}
