//
//  TopicsPage + UIPageViewControllerDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

// MARK: - UIPageViewControllerDataSource
extension TopicsPageViewController: UIPageViewControllerDataSource {
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard
      let contentViewController = viewController as? TopicPhotoListViewController,
      let index = contentViewController.pageIndex
    else {
      return nil
    }
    return viewControllerForTopic(at: index - 1)
  }
  
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard
      let contentViewController = viewController as? TopicPhotoListViewController,
      let index = contentViewController.pageIndex
    else {
      return nil
    }
    return viewControllerForTopic(at: index + 1)
  }
  
  func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
  ) {
    guard completed else { return }
    handlePageViewControllerTransition(pageViewController)
  }
  
  // MARK: - Private Methods
  private func handlePageViewControllerTransition(
    _ pageViewController: UIPageViewController
  ) {
    guard
      let visibleViewController = pageViewController
        .viewControllers?
        .first as? TopicPhotoListViewController,
      let currentIndex = visibleViewController.pageIndex
    else {
      return
    }
    
    let indexPath = IndexPath(item: currentIndex, section: .zero)
    
    guard
      let cell = rootView.categoryCollectionView.cellForItem(at: indexPath)
    else {
      return
    }
    selectItem(at: indexPath)
    rootView.categoryCollectionView.updateIndicatorPosition(for: cell)
  }
  
  private func selectItem(at indexPath: IndexPath) {
    rootView.categoryCollectionView.selectItem(
      at: indexPath,
      animated: true,
      scrollPosition: .centeredHorizontally
    )
  }
}
