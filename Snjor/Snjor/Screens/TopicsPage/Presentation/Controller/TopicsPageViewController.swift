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
  
  deinit {
    print("TopicsPageViewController - Деинициализирован")
  }
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewDidLoad()
    stateController()
    configurePageViewController()
    configureCategoryCollectionView()
    rootView.backgroundColor = .systemBackground
  }
  
  // MARK: - Internal Methods
  func viewControllerForTopic(at index: Int) -> UIViewController? {
    guard 
      index >= 0,
      index < viewModel.topicsCount 
    else {
      return nil
    }
    let topicsPagePhotoListFactory = TopicsPagePhotoListFactory(topic: viewModel.topics[index])
    guard
      let topicsPagePhotoListViewController = topicsPagePhotoListFactory.makeModule(
        delegate: self
      ) as? TopicPhotoListCollectionViewController
    else {
      return UIViewController()
    }
    topicsPagePhotoListViewController.topicID = viewModel.topics[index].id
    topicsPagePhotoListViewController.pageIndex = index
    return topicsPagePhotoListViewController
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
    rootView.categoryCollectionView.showsHorizontalScrollIndicator = false
    rootView.categoryCollectionView.dataSource = self
    rootView.categoryCollectionView.delegate = self
    rootView.categoryCollectionView.register(
      TopicsCell.self,
      forCellWithReuseIdentifier: TopicsCell.reuseID
    )
  }
}

extension TopicsPageViewController: MessageDisplayable { }
