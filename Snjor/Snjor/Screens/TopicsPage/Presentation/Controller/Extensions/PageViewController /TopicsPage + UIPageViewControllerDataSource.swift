//
//  TopicsPage + UIPageViewControllerDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

// MARK: - UIPageViewControllerDataSource
extension TopicsPageViewController: UIPageViewControllerDataSource {
  
  // обратно
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard let photosVC = viewController as? TopicPhotoListCollectionViewController,
          let index = photosVC.pageIndex
    else {
      return nil
    }
    return viewControllerForTopic(at: index - 1)
  }
  
  //туда
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard let photosVC = viewController as? TopicPhotoListCollectionViewController,
          let index = photosVC.pageIndex
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
    if completed,
       let visibleViewController = pageViewController.viewControllers?.first as? TopicPhotoListCollectionViewController,
       let index = visibleViewController.pageIndex {
      rootView.categoryCollectionView.selectItem(
        at: IndexPath(item: index, section: 0),
        animated: true,
        scrollPosition: .centeredHorizontally
      )
    }
  }
}

extension TopicsPageViewController: TopicPhotoListCollectionViewControllerDelegate {
  func didSelect(_ photo: Photo) {
    print(#function)
  }
}
