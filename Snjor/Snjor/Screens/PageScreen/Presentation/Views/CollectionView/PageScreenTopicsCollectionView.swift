//
//  PageScreenTopicsCollectionView.swift
//  Snjor
//
//  Created by Adam on 27.07.2024.
//

import UIKit

fileprivate typealias Const = PageScreenTopicsCollectionViewConst

final class PageScreenTopicsCollectionView: BaseCollectionView {
  // MARK: Views
  private let lineView: UIView = {
    $0.backgroundColor = .white
    $0.alpha = Const.lineViewOpacity
    return $0
  }(UIView())
  
  private let indicatorView: UIView = {
    $0.backgroundColor = .white
    return $0
  }(UIView())
  
  // MARK: Initializers
  override init() {
    super.init()
    configureLayout()
    addSubviews()
    cellRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }

  // MARK: Override Methods
  override func layoutSubviews() {
    super.layoutSubviews()
    updateLineViewAndIndicatorPosition()
  }
  
  // MARK: Internal Methods
  /// Обновляет позицию индикатора в зависимости от положения указанной ячейки.
  /// - Parameter cell: Ячейка, для которой необходимо обновить позицию индикатора.
  ///
  /// Расчитывает новую позицию индикатора на основе положения ячейки и её размеров.
  /// Индикатор располагается внизу ячейки, и его высота вычисляется с учетом разрешения дисплея.
  func updateIndicatorPosition(for cell: UICollectionViewCell) {
    // Получение фрейма ячейки.
    let cellFrame = cell.frame
    
    // Толщина индикатора с учетом разрешения дисплея.
    let indicatorHeight: CGFloat = traitCollection.displayScale * Const.indicatorHeightMultiplier
    
    // Определение новых координат для индикатора.
    let xPosition = cellFrame.origin.x
    let yPosition = cellFrame.maxY - indicatorHeight
    
    // Создание нового фрейма для индикатора.
    let newFrame = CGRect(
      x: xPosition,
      y: yPosition,
      width: cellFrame.width,
      height: indicatorHeight
    )
    
    // Проверка, изменилась ли позиция индикатора.
    guard indicatorView.frame != newFrame else { return }
    
    // Анимация изменения позиции индикатора.
    animateCellIndicator(indicatorView: indicatorView, newFrame: newFrame)
  }
  
  // MARK: Private Methods
  private func addSubviews() {
    addSubview(lineView)
    addSubview(indicatorView)
  }
  
  override func configureLayout() {
    flowlayout.scrollDirection = .horizontal
    backgroundColor = .clear
    bounces = false
    showsHorizontalScrollIndicator = false
  }
  
  override func cellRegister() {
    register(
      PageScreenTopicCell.self,
      forCellWithReuseIdentifier: PageScreenTopicCell.reuseID
    )
  }
  
  private func animateCellIndicator(indicatorView: UIView, newFrame: CGRect) {
    UIView.animate(withDuration: .zero) {
      self.indicatorView.frame = newFrame
    }
  }
  
  /// Обновляет положение линии и индикатора на основе текущих размеров и состояния представления.
  ///
  /// Устанавливает размеры `lineView` в соответствии с высотой индикатора и
  /// обновляет позицию индикатора, основываясь на выбранной ячейке в коллекции.
  /// Если нет выбранной ячейки, метод завершает выполнение.
  private func updateLineViewAndIndicatorPosition() {
    // Высота индикатора с учетом разрешения дисплея.
    let indicatorHeight: CGFloat = Const.indicatorBaseHeight / traitCollection.displayScale
    
    // Установка фрейма для `lineView`, который находится внизу представления.
    lineView.frame = CGRect(
      x: .zero,
      y: bounds.height - indicatorHeight,
      width: contentSize.width,
      height: indicatorHeight
    )
    
    // Получение индекса выбранной ячейки и самой ячейки.
    guard
      let selectedIndexPath = indexPathsForSelectedItems?.first,
      let cell = cellForItem(at: selectedIndexPath)
    else {
      return
    }
    
    // Обновление позиции индикатора для выбранной ячейки.
    updateIndicatorPosition(for: cell)
  }
}
