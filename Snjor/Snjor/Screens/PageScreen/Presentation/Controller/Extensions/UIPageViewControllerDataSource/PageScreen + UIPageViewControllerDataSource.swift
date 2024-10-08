//
//  PageScreen + UIPageViewControllerDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

extension PageScreenViewController: UIPageViewControllerDataSource {
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard
      let contentViewController = viewController as? PageScreenPhotosViewController,
      let index = contentViewController.pageIndex
    else {
      return nil
    }
    return viewControllerForTopic(at: index - 1, delegate: coordinator)
  }
  
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard
      let contentViewController = viewController as? PageScreenPhotosViewController,
      let index = contentViewController.pageIndex
    else {
      return nil
    }
    return viewControllerForTopic(at: index + 1, delegate: coordinator)
  }
}
