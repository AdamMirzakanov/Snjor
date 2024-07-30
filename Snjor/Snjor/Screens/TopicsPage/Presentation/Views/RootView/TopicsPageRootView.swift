//
//  TopicsPageRootView.swift
//  Snjor
//
//  Created by Adam on 26.07.2024.
//

import UIKit

final class TopicPageRootView: UIView {
  
  // MARK: - Views
  let appNameLabel: UILabel = {
    let text = "Snjør".uppercased()
    let fontSize = UIFont.systemFont(ofSize: 20, weight: .medium)
    let attributes: [NSAttributedString.Key: Any] = [
      .kern: 4.5,
      .font: fontSize
    ]
    $0.attributedText = NSAttributedString(string: text, attributes: attributes)
    $0.textColor = .white
    return $0
  }(UILabel())
  
  var pageViewController: UIPageViewController = {
    $0.view.backgroundColor = .clear
    return $0
  }(UIPageViewController(
    transitionStyle: .scroll,
    navigationOrientation: .horizontal,
    options: nil
  ))
  
  var categoryCollectionView: TopicsPageCategoryCollectionView = {
    return $0
  }(TopicsPageCategoryCollectionView())
  
  private let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      GradientView.Color(
        color: UIColor(white: 0, alpha: 1.0),
        location: 0.1
      ),
      GradientView.Color(
        color: .clear,
        location: 0.25
      ),
    ])
    $0.isUserInteractionEnabled = false
    return $0
  }(GradientView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(pageViewController.view)
    addSubview(gradientView)
    addSubview(categoryCollectionView)
    addSubview(appNameLabel)
  }
  
  private func setupConstraints() {
    setupCategoryCollectionViewConstraints()
    setupPageViewControllerViewConstraints()
    setupGradientViewConstraints()
    setupAppNameLabelConstraints()
  }
  
  private func setupCategoryCollectionViewConstraints() {
    categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      categoryCollectionView.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor, constant: 45),
      categoryCollectionView.leadingAnchor.constraint(
        equalTo: leadingAnchor),
      categoryCollectionView.trailingAnchor.constraint(
        equalTo: trailingAnchor),
      categoryCollectionView.heightAnchor.constraint(
        equalToConstant: 40)
    ])
  }
  
  private func setupPageViewControllerViewConstraints() {
    pageViewController.view.fillSuperView()
  }
  
  private func setupGradientViewConstraints() {
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(
        equalTo: topAnchor, constant: -40),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
      gradientView.leadingAnchor.constraint(
        equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(
        equalTo: trailingAnchor)
    ])
  }
  
  private func setupAppNameLabelConstraints() {
    appNameLabel.centerX()
    NSLayoutConstraint.activate([
      appNameLabel.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor, constant: 15)
    ])
    
  }
}
