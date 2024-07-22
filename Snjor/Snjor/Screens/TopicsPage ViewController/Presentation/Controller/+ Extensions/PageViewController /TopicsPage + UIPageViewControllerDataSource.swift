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
    let photosViewController = TopicsPhotosCollectionViewController(
      viewModel: <#T##any TopicsPhotosViewModelProtocol#>,
      delegate: <#T##any TopicsPhotosViewControllerDelegate#>,
      layout: <#T##UICollectionViewLayout#>
    )
    photosViewController.topicID = viewModel.topics[index].id
    photosViewController.title = viewModel.topics[index].title
    photosViewController.pageIndex = index
    return photosViewController
  }
  
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard let photosVC = viewController as? TopicsPhotosCollectionViewController,
          let index = photosVC.pageIndex
    else {
      return nil
    }
    return viewControllerForTopic(at: index - 1)
  }
  
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard let photosVC = viewController as? TopicsPhotosCollectionViewController,
          let index = photosVC.pageIndex
    else {
      return nil
    }
    return viewControllerForTopic(at: index + 1)
  }
}
