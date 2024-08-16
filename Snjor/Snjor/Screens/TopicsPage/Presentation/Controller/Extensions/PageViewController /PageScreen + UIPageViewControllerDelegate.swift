//
//  PageScreen + UIPageViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

// MARK: - UIPageViewControllerDelegate
extension PageScreenViewController: UIPageViewControllerDelegate { 
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
        .first as? TopicPhotosViewController,
      let currentIndex = visibleViewController.pageIndex
    else {
      return
    }
    
    let indexPath = IndexPath(item: currentIndex, section: .zero)
    
    guard
      let cell = rootView.topicsCollectionView.cellForItem(at: indexPath)
    else {
      return
    }
    selectItem(at: indexPath)
    rootView.topicsCollectionView.updateIndicatorPosition(for: cell)
  }
  
  private func selectItem(at indexPath: IndexPath) {
    rootView.topicsCollectionView.selectItem(
      at: indexPath,
      animated: true,
      scrollPosition: .centeredHorizontally
    )
  }
  
}
