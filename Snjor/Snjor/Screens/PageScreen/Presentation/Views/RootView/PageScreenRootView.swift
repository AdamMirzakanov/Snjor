//
//  PageScreenRootView.swift
//  Snjor
//
//  Created by Adam on 26.07.2024.
//

import UIKit

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
      equalToConstant: PageScreenRootViewConst.topicsCollectionViewHeight
    ).isActive = true
    return $0
  }(PageScreenTopicsCollectionView())
  
  // MARK: Private Views
  private let appNameLabel: UILabel = {
    let text = "Snjør".uppercased()
    let fontSize = UIFont.systemFont(
      ofSize: PageScreenRootViewConst.appNameLabelFontSize,
      weight: .bold
    )
    let attributes: [NSAttributedString.Key: Any] = [
      .kern: PageScreenRootViewConst.appNameLabelTextKern,
      .font: fontSize
    ]
    $0.attributedText = NSAttributedString(string: text, attributes: attributes)
    $0.textColor = .white
    return $0
  }(UILabel())
  
  private let gradientView: MainGradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      MainGradientView.Color(
        color: UIColor(
          white: .zero,
          alpha: PageScreenRootViewConst.gradientOpacity
        ),
        location: PageScreenRootViewConst.gradientStartLocation
      ),
      MainGradientView.Color(
        color: .clear,
        location: PageScreenRootViewConst.gradientEndLocation
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
    fatalError(.requiredInitFatalErrorText)
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
    setupCategoryCollectionViewConstraints()
    setupPageViewControllerViewConstraints()
    setupGradientViewConstraints()
    setupAppNameLabelConstraints()
  }
  
  private func setupCategoryCollectionViewConstraints() {
    topicsCollectionView.setConstraints(
      top: safeAreaLayoutGuide.topAnchor,
      right: rightAnchor,
      left: leftAnchor,
      pTop: PageScreenRootViewConst.topicsCollectionViewTopAnchor
    )
  }
  
  private func setupPageViewControllerViewConstraints() {
    pageViewController.view.fillSuperView()
  }
  
  private func setupGradientViewConstraints() {
    gradientView.setConstraints(
      top: topAnchor,
      right: rightAnchor,
      bottom: bottomAnchor,
      left: leftAnchor,
      pTop: PageScreenRootViewConst.gradientViewTopAnchor
    )
  }
  
  private func setupAppNameLabelConstraints() {
    appNameLabel.centerX()
    appNameLabel.setConstraints(
      top: safeAreaLayoutGuide.topAnchor,
      pTop: PageScreenRootViewConst.appNameLabelTopAnchor
    )
  }
}
