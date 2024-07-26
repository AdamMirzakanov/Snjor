//
//  TopicsPageRootView.swift
//  Snjor
//
//  Created by Adam on 26.07.2024.
//

import UIKit

final class TopicPageRootView: UIView {
  // MARK: - Private Properties
  
  // MARK: - Views
  var pageViewController: UIPageViewController = {
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
    collectionView.backgroundColor = .systemBackground
    return collectionView
  }()
  
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
    addSubview(categoryCollectionView)
    addSubview(pageViewController.view)
  }
  
  private func setupConstraints() {
    
    // collection view
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
    
    // page view controller
    pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pageViewController.view.topAnchor.constraint(
        equalTo: categoryCollectionView.bottomAnchor),
      pageViewController.view.bottomAnchor.constraint(
        equalTo: bottomAnchor),
      pageViewController.view.leadingAnchor.constraint(
        equalTo: leadingAnchor),
      pageViewController.view.trailingAnchor.constraint(
        equalTo: trailingAnchor)
    ])
  }
}
