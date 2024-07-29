//
//  TopicsPage + UIPageViewControllerDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

// MARK: - UIPageViewControllerDataSource
extension TopicsPageViewController: UIPageViewControllerDataSource {
  
  // перед текущим контроллером
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard let contentViewController = viewController as? TopicPhotoListCollectionViewController,
          let index = contentViewController.pageIndex
    else {
      return nil
    }
    return viewControllerForTopic(at: index - 1)
  }
  
  // после текущего
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard let contentViewController = viewController as? TopicPhotoListCollectionViewController,
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
    if completed,
       let visibleViewController = pageViewController.viewControllers?.first as? TopicPhotoListCollectionViewController,
       let currentIndex = visibleViewController.pageIndex {
      
      rootView.categoryCollectionView.selectItem(
        at: IndexPath(item: currentIndex, section: .zero),
        animated: true,
        scrollPosition: .centeredHorizontally
      )
      
      if let cell = rootView.categoryCollectionView.cellForItem(at: IndexPath(item: currentIndex, section: 0)) {
            rootView.categoryCollectionView.updateIndicatorPosition(for: cell)
          }
    }
  }
}

//extension TopicsPageViewController: TopicPhotoListCollectionViewControllerDelegate {
//  func didSelect(_ photo: Photo) {
//    let photoDetailFactory = PhotoDetailFactory(photo: photo)
//    let controller = photoDetailFactory.makeModule()
//    navigationController?.pushViewController(
//      controller,
//      animated: true
//    )
//    print(#function)
//  }
//}
