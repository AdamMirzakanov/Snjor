//
//  UserProfileViewController + ScrollViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

fileprivate typealias Const = UserProfileViewControllerConst

extension UserProfileViewController: UICollectionViewDelegate {
  
  /// Вызывается при прокрутке содержимого `scrollView`.
  /// Обновляет положение и ширину индикатора в зависимости от текущего смещения прокрутки.
  /// Также обновляет состояние кнопок на основе видимой страницы.
  ///
  /// - Parameter scrollView: `UIScrollView`, содержащий коллекцию.
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    // Получаем текущую позицию по оси X и ширину `scrollView`.
    let contentOffsetX = scrollView.contentOffset.x
    let scrollViewWidth = scrollView.frame.width
    
    // Рассчитываем прогресс прокрутки на основе смещения и ширины.
    let progress = contentOffsetX / scrollViewWidth
    
    // Задаем ширину индикатора, деля ширину `scrollView` на 3 (количество вкладок).
    let indicatorWidth = scrollViewWidth / Const.indicatorWidthDivision
    
    // Определяем позицию индикатора на основе прогресса прокрутки.
    let position = progress * indicatorWidth
    
    // Устанавливаем новую позицию и ширину индикатора.
    rootView.indicatorView.frame.origin.x = position
    rootView.indicatorView.frame.size.width = indicatorWidth
    
    // Обновляем состояния кнопок в зависимости от текущей видимой страницы.
    rootView.updateButtonStatesForVisiblePage(for: userProfileViewModel)
  }
}

