//
//  TopicsPageViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

final class TopicsPageViewController: UIViewController {
  
  // MARK: - Private Properties
  var pageViewController: UIPageViewController!
  private var collectionView: UICollectionView!
  private(set) var viewModel: any TopicsPageViewModelProtocol
  
  // MARK: - Initializers
  init(
    viewModel: any TopicsPageViewModelProtocol
  ) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewDidLoad()
    setupCollectionView()
    setupPageViewController()
    view.backgroundColor = .systemBlue
  }
  
  // MARK: - Private Methods
  private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .white
    collectionView.register(
      TopicsCell.self,
      forCellWithReuseIdentifier: TopicsCell.reuseID
    )
    
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor
      ),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func setupPageViewController() {
    pageViewController = UIPageViewController(
      transitionStyle: .scroll,
      navigationOrientation: .horizontal,
      options: nil
    )
    pageViewController.dataSource = self
    pageViewController.delegate = self
    
    addChild(pageViewController)
    view.addSubview(pageViewController.view)
    pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pageViewController.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
      pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    pageViewController.didMove(toParent: self)
  }
  
  
}
