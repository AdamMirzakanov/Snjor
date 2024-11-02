//
//  PageScreenRootView.swift
//  Snjor
//
//  Created by Adam on 26.07.2024.
//

import UIKit

fileprivate typealias Const = PageScreenRootViewConst

final class PageScreenRootView: UIView {
  // MARK: Internal Views
  let pageViewController: UIPageViewController = {
    $0.view.backgroundColor = .clear
    return $0
  }(UIPageViewController(
    transitionStyle: .scroll,
    navigationOrientation: .horizontal,
    options: nil
  ))
  
  let topicsCollectionView: PageScreenTopicsCollectionView = {
    $0.heightAnchor.constraint(
      equalToConstant: Const.topicsCollectionViewHeight
    ).isActive = true
    return $0
  }(PageScreenTopicsCollectionView())
  
  // MARK: Private Views
  private let appNameLabel: UILabel = {
    let text = "Snjør".uppercased()
    let fontSize = UIFont.systemFont(
      ofSize: Const.appNameLabelFontSize,
      weight: .light
    )
    let attributes: [NSAttributedString.Key: Any] = [
      .kern: Const.appNameLabelTextKern,
      .font: fontSize
    ]
    $0.attributedText = NSAttributedString(string: text, attributes: attributes)
    $0.textColor = .white
    return $0
  }(UILabel())
  
  private let gradientView: MainGradientView = {
    $0.setColors([
      MainGradientView.Color(
        color: UIColor(
          white: .zero,
          alpha: Const.gradientOpacity
        ),
        location: Const.gradientStartLocation
      ),
      MainGradientView.Color(
        color: .clear,
        location: Const.gradientEndLocation
      ),
    ])
    $0.isUserInteractionEnabled = false
    return $0
  }(MainGradientView())
  
  // MARK: Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(pageViewController.view)
    addSubview(gradientView)
    addSubview(topicsCollectionView)
    addSubview(appNameLabel)
  }
  
  private func setupConstraints() {
    setupTopicsCollectionViewConstraints()
    setupPageViewControllerViewConstraints()
    setupGradientViewConstraints()
    setupAppNameLabelConstraints()
  }
  
  private func setupTopicsCollectionViewConstraints() {
    topicsCollectionView.setConstraints(
      top: safeAreaLayoutGuide.topAnchor,
      right: rightAnchor,
      left: leftAnchor,
      pTop: Const.topicsCollectionViewTopAnchor
    )
  }
  
  private func setupPageViewControllerViewConstraints() {
    pageViewController.view.setConstraints(
      top: safeAreaLayoutGuide.topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor
    )
  }
  
  private func setupGradientViewConstraints() {
    gradientView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pTop: Const.gradientViewTopAnchor
    )
  }
  
  private func setupAppNameLabelConstraints() {
    appNameLabel.centerX()
    appNameLabel.setConstraints(
      top: safeAreaLayoutGuide.topAnchor,
      pTop: Const.appNameLabelTopAnchor
    )
  }
}
