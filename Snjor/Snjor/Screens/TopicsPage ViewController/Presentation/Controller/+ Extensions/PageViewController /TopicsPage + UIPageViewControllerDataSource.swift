//
//  TopicsPage + UIPageViewControllerDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

// MARK: - UIPageViewControllerDataSource
extension TopicsPageViewController: UIPageViewControllerDataSource {

  
  func viewControllerForTopic(at index: Int) -> UIViewController? {
    guard index >= 0 && index < viewModel.topicsCount else { return nil }
    let photosViewController = photoListFactory.makeModule(delegate: self) as! PhotoListCollectionViewController
    photosViewController.topicID = viewModel.topics[index].id
    photosViewController.title = viewModel.topics[index].title
    photosViewController.pageIndex = index
    return photosViewController
  }
  
  // обратно
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard let photosVC = viewController as? PhotoListCollectionViewController,
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
    guard let photosVC = viewController as? PhotoListCollectionViewController,
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
       let visibleViewController = pageViewController.viewControllers?.first as? PhotosCollectionViewController,
       let index = visibleViewController.pageIndex {
      collectionView.selectItem(
        at: IndexPath(item: index, section: 0),
        animated: true,
        scrollPosition: .centeredHorizontally
      )
    }
  }
}

extension TopicsPageViewController: PhotoListViewControllerDelegate {
  func didSelect(_ photo: Photo) {
    print(#function)
  }
}
