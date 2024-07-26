//
//  TopicsPageRootView.swift
//  Snjor
//
//  Created by Adam on 26.07.2024.
//

import UIKit

final class TopicPageRootView: UIView {
  
  // MARK: - Views
  var pageViewController: UIPageViewController = {
    $0.view.backgroundColor = .clear
    return $0
  }(UIPageViewController(
    transitionStyle: .scroll,
    navigationOrientation: .horizontal,
    options: nil
  ))
  
  var categoryCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    collectionView.backgroundColor = .clear
    return collectionView
  }()
  
  private let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      GradientView.Color(
        color: UIColor(white: 0, alpha: 1.0),
        location: 0.065
      ),
      GradientView.Color(
        color: .clear,
        location: 0.15
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
    addSubview(categoryCollectionView)
    addSubview(gradientView)
  }
  
  private func setupConstraints() {
    setupCategoryCollectionViewConstraints()
    setupPageViewControllerViewConstraints()
    setupGradientViewConstraints()
  }
  
  private func setupCategoryCollectionViewConstraints() {
    categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      categoryCollectionView.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor),
      categoryCollectionView.leadingAnchor.constraint(
        equalTo: leadingAnchor),
      categoryCollectionView.trailingAnchor.constraint(
        equalTo: trailingAnchor),
      categoryCollectionView.heightAnchor.constraint(
        equalToConstant: 50)
    ])
  }
  
  private func setupPageViewControllerViewConstraints() {
    pageViewController.view.fillSuperView()
  }
  
  private func setupGradientViewConstraints() {
    gradientView.fillSuperView()
  }
}
