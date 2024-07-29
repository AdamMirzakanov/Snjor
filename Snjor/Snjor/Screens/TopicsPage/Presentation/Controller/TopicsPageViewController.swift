//
//  TopicsPageViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit
import Combine

final class TopicsPageViewController: BaseViewController<TopicPageRootView> {
  
  // MARK: - Private Properties
  private(set) var viewModel: any TopicsPageViewModelProtocol
  private var cancellable = Set<AnyCancellable>()
  
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
    rootView.backgroundColor = .systemBackground
    configurePageViewController()
    configureCategoryCollectionView()
    stateController()
    viewModel.viewDidLoad()
    
    DispatchQueue.main.async {
      if let firstCell = self.rootView.categoryCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) {
        self.rootView.categoryCollectionView.updateIndicatorPosition(for: firstCell)
      }
    }
  }
  
  // Словарь для кэширования контроллеров
  private var cachedViewControllers: [Int: TopicPhotoListCollectionViewController] = [:]
  private let maxCachedControllers = 3
  private var orderedKeys: [Int] = []
  
  // MARK: - Internal Methods
  func viewControllerForTopic(at index: Int) -> UIViewController? {
    guard 
      index >= 0,
      index < viewModel.topicsCount 
    else {
      return nil
    }
    
    if let cachedController = cachedViewControllers[index] {
      return cachedController
    }
    
    let topicsPageViewModelItem = viewModel.getTopicsPageViewModelItem(at: index)
    
    let topicsPagePhotoListFactory = TopicsPagePhotoListFactory(
      topic: topicsPageViewModelItem.topic
    )
    
    let topicID = topicsPageViewModelItem.topicID
    guard let topicsPagePhotoListViewController = topicsPagePhotoListFactory.makeModule() as?  TopicPhotoListCollectionViewController 
    else { return UIViewController() }
    topicsPagePhotoListViewController.topicID = topicID
    topicsPagePhotoListViewController.pageIndex = index
    cacheController(index: index, controller: topicsPagePhotoListViewController)
    return topicsPagePhotoListViewController
  }
  
  private func cacheController(index: Int, controller: TopicPhotoListCollectionViewController) {
    if cachedViewControllers.count >= maxCachedControllers {
      if let oldestKey = orderedKeys.first {
        cachedViewControllers.removeValue(forKey: oldestKey)
        orderedKeys.removeFirst()
      }
    }
    
    cachedViewControllers[index] = controller
    orderedKeys.append(index)
    
    if orderedKeys.count > maxCachedControllers {
      let removedKey = orderedKeys.removeFirst()
      cachedViewControllers.removeValue(forKey: removedKey)
    }
  }
  
  // MARK: - Private Methods
  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          self.rootView.categoryCollectionView.reloadData()
          guard let firstPage = self.viewControllerForTopic(at: 0)
          else { return }
          rootView.pageViewController.setViewControllers(
            [firstPage],
            direction: .forward,
            animated: true
          )
        case .loading: break
        case .fail(error: let error):
          presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }
  
  private func configurePageViewController() {
    rootView.pageViewController.dataSource = self
    rootView.pageViewController.delegate = self
    addChild(rootView.pageViewController)
    rootView.pageViewController.didMove(toParent: self)
  }
  
  private func configureCategoryCollectionView() {
    rootView.categoryCollectionView.dataSource = self
    rootView.categoryCollectionView.delegate = self
  }
}

extension TopicsPageViewController: MessageDisplayable { }

//extension TopicsPageViewController: TopicPhotoListCollectionViewControllerDelegate {
//  func didSelect(_ photo: Photo) {
//    print(#function)
//  }
//}
