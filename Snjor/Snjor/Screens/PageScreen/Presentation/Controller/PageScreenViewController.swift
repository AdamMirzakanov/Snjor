//
//  PageScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit
import Combine

final class PageScreenViewController: MainViewController<PageScreenRootView> {
  // MARK: Internal Properties
  var categoriesdataSource: СategoriesDataSource?
  
  // MARK: Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var viewModel: any ContentManagingProtocol <Topic>
  private(set) var coordinator: any PageScreenPhotosViewControllerDelegate
  
  // MARK: Initializers
  init(
    viewModel: any ContentManagingProtocol <Topic>,
    coordinator: any PageScreenPhotosViewControllerDelegate
  ) {
    self.viewModel = viewModel
    self.coordinator = coordinator
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: View Lifecycle
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
    showCustomTabBar()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    updateIndicatorToInitialPosition()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    setNavigationBarHidden(false, animated: animated)
    hideCustomTabBar()
  }
  
  // MARK: Internal Methods
  func viewControllerForTopic(
    at index: Int,
    delegate: any PageScreenPhotosViewControllerDelegate
  ) -> UIViewController? {
    guard
      index >= .zero,
      index < viewModel.items.count else {
      return nil
    }
    
    let topicsPageViewModelItem = viewModel.getViewModelItem(at: index)
    let topic = topicsPageViewModelItem.item
    let topicPhotoListFactory = PageScreenTopicPhotosFactory(topic: topic)
    let topicID = topicsPageViewModelItem.itemID
    let viewController = topicPhotoListFactory.makeController(delegate: coordinator)
    
    guard let topicPhotoListCollectionViewController = (
      viewController as? PageScreenPhotosViewController
    ) else {
      return viewController
    }
    
    topicPhotoListCollectionViewController.topicID = topicID
    topicPhotoListCollectionViewController.pageIndex = index
    return topicPhotoListCollectionViewController
  }
  
  // MARK: Private Methods
  private func setupDataSource() {
    createDataSource(
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
          applySnapshot()
          setFirstPage()
        case .loading: break
        case .fail(error: let error):
          presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }
  
  private func setFirstPage() {
    guard 
      let firstPage = self.viewControllerForTopic(at: .zero, delegate: coordinator)
    else {
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
    rootView.topicsCollectionView.delegate = self
  }
  
  private func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
    self.navigationController?.setNavigationBarHidden(hidden, animated: animated)
  }
  
  private func updateIndicatorToInitialPosition() {
    let firstItemIndexPath = IndexPath(item: .zero, section: .zero)
    guard 
      let cell = rootView.topicsCollectionView.cellForItem(at: firstItemIndexPath)
    else {
      return
    }
    rootView.topicsCollectionView.updateIndicatorPosition(for: cell)
  }
}
