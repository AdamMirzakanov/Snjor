//
//  PageScreen + UIPageViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

extension PageScreenViewController: UIPageViewControllerDelegate { 
  func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
  ) {
    // Проверка, был ли переход завершён успешно.
    guard completed else { return }
    // Обработка перехода в `pageViewController`.
    handlePageViewControllerTransition(pageViewController)
  }
  
  // MARK: Private Methods
  /// Обрабатывает переход между страницами в `UIPageViewController`.
  ///
  /// - Parameter pageViewController: Контроллер страниц, для которого обрабатывается переход.
  private func handlePageViewControllerTransition(
    _ pageViewController: UIPageViewController
  ) {
    // Получение видимого контроллера и его индекса.
    guard
      let visibleViewController = pageViewController
        .viewControllers?
        .first as? PageScreenPhotosViewController,
      let currentIndex = visibleViewController.pageIndex
    else {
      return
    }
    
    // Создание `IndexPath` для текущей страницы.
    let indexPath = IndexPath(item: currentIndex, section: .zero)
    
    // Получение ячейки коллекции по `indexPath`.
    guard
      let cell = rootView.topicsCollectionView.cellForItem(at: indexPath)
    else {
      return
    }
    // Выбор элемента в коллекции и обновление позиции индикатора.
    selectItem(at: indexPath)
    rootView.topicsCollectionView.updateIndicatorPosition(for: cell)
  }
  
  /// Выбирает элемент в коллекции по заданному `IndexPath`.
  /// - Parameter indexPath: `IndexPath` для ячейки, которую необходимо выбрать.
  private func selectItem(at indexPath: IndexPath) {
    rootView.topicsCollectionView.selectItem(
      at: indexPath,
      animated: true,
      scrollPosition: .centeredHorizontally
    )
  }
}
