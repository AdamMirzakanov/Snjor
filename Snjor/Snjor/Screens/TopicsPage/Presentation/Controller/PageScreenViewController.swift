//
//  PageScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit
import Combine

final class PageScreenViewController: BaseViewController<PageScreenRootView> {
  
  // MARK: - Private Properties
  private(set) var viewModel: any TopicsViewModelProtocol
  private var cancellable = Set<AnyCancellable>()
  
  // MARK: - Initializers
  init(
    viewModel: any TopicsViewModelProtocol
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
    setupDataSource()
    setFirstPage()
    configPageViewController()
    configCategoryCollectionView()
    viewModel.viewDidLoad()
    stateController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    updateIndicatorToInitialPosition()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    setNavigationBarHidden(false, animated: animated)
  }
  
  // MARK: - Internal Methods
  func viewControllerForTopic(at index: Int) -> UIViewController? {
    guard
      index >= 0,
      index < viewModel.topicsCount else {
      return nil
    }
    
    let topicsPageViewModelItem = viewModel.getTopicsPageViewModelItem(at: index)
    let topic = topicsPageViewModelItem.topic
    let topicPhotoListFactory = TopicPhotosFactory(topic: topic)
    let topicID = topicsPageViewModelItem.topicID
    let viewController = topicPhotoListFactory.makeModule(
      delegate: self,
      layoutType: .singleColumn
    )
    
    guard let topicPhotoListCollectionViewController = (
      viewController as? TopicPhotosViewController
    ) else {
      return viewController
    }
    
    topicPhotoListCollectionViewController.topicID = topicID
    topicPhotoListCollectionViewController.pageIndex = index
    return topicPhotoListCollectionViewController
  }
  
  
  // MARK: - Private Methods
  private func setupDataSource() {
    viewModel.createDataSource(
      for: rootView.topicsCollectionView
    )
  }
  
  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          viewModel.applySnapshot()
          setFirstPage()
        case .loading: break
        case .fail(error: let error):
          presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }
  
  private func setFirstPage() {
    guard let firstPage = self.viewControllerForTopic(at: .zero) else {
      return
    }
    rootView.pageViewController.setViewControllers(
      [firstPage],
      direction: .forward,
      animated: true
    )
  }
  
  private func configPageViewController() {
    rootView.pageViewController.dataSource = self
    rootView.pageViewController.delegate = self
    addChild(rootView.pageViewController)
    rootView.pageViewController.didMove(toParent: self)
    rootView.backgroundColor = .systemBackground
  }
  
  private func configCategoryCollectionView() {
    //        rootView.categoryCollectionView.dataSource = self
    rootView.topicsCollectionView.delegate = self
  }
  
  private func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
    self.navigationController?.setNavigationBarHidden(hidden, animated: animated)
  }
  
  private func updateIndicatorToInitialPosition() {
    let firstItemIndexPath = IndexPath(item: .zero, section: .zero)
    guard let cell = rootView.topicsCollectionView.cellForItem(at: firstItemIndexPath) else {
      return
    }
    rootView.topicsCollectionView.updateIndicatorPosition(for: cell)
  }
}
