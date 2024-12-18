//
//  TopicPhotosRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

fileprivate typealias Const = TopicPhotosRootViewConst

final class TopicPhotosRootView: BaseView {
  // MARK: Private Properties
  private var backButtonAction: (() -> Void)?
  
  // MARK: Views
  let topicPhotosCollectionView: TopicPhotosCollectionView = {
    return $0
  }(TopicPhotosCollectionView())
  
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
  override func initViews() {
    setupViews()
  }

  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(topicPhotosCollectionView)
    backBarButtonBackgroundView.addSubview(backBarButton)
  }
  
  private func setupConstraints() {
    topicPhotosCollectionView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor
    )
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
