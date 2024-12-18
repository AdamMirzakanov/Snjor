//
//  CascadeLayout.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import UIKit

fileprivate typealias Const = CascadeLayoutConst

/// Класс `CascadeLayout` представляет собой пользовательский макет для `UICollectionView`,
/// который организует ячейки в каскадном стиле. Он позволяет изменять расположение ячеек
/// в зависимости от их размеров, создавая эффект, при котором ячейки выглядят как падающие
/// в каскаде, что добавляет визуального интереса к пользовательскому интерфейсу.
class CascadeLayout: UICollectionViewLayout {
  
  // MARK: Internal Properties
  var attributes: [UICollectionViewLayoutAttributes] = []
  
  /// Свойство `contentHeight` представляет собой высоту содержимого макета в виде `CGFloat`.
  /// Оно инициализируется значением `.zero` и используется для вычисления общей высоты
  /// области прокрутки `UICollectionView`, что позволяет правильно отображать ячейки
  /// при их размещении в каскадном стиле.
  var contentHeight: CGFloat = .zero
  
  /// Свойство `numberOfColumns` определяет количество столбцов в макете `CascadeLayout`.
  /// Инициализируется значением `.zero`, но должно быть установлено в конкретное значение
  /// перед использованием, чтобы контролировать распределение ячеек по горизонтали.
  var numberOfColumns: Int = .zero
  
  /// Свойство `isSingleColumn` вычисляет, является ли макет одностолбцовым,
  /// проверяя, равно ли свойство `numberOfColumns` нулю.
  /// Возвращает `true`, если столбцов нет, и `false` в противном случае.
  var isSingleColumn: Bool { numberOfColumns == .zero }
  
  /// Свойство `topInset` определяет верхний отступ для макета в виде `CGFloat`.
  var topInset: CGFloat {
    return .zero  
  }

  /// Свойство `columnSpacing` определяет расстояние между столбцами в макете в виде `CGFloat`.
  var columnSpacing: CGFloat = Const.columnSpacing
  
  /// Свойство `itemSpacing` вычисляет расстояние между элементами в зависимости от того,
  /// является ли макет одностолбцовым. Если `isSingleColumn` равно `true`, возвращает
  /// `CGFloat.zero`, иначе возвращает значение `columnSpacing`. Это позволяет
  /// адаптировать отступы между элементами в зависимости от количества столбцов.
  var itemSpacing: CGFloat {
    let zero = CGFloat.zero
    return isSingleColumn ? zero : columnSpacing
  }
  
  /// Свойство `columnWidth` вычисляет ширину столбца в зависимости от общей
  /// ширины содержимого `UICollectionView`. Если макет является
  /// одностолбцовым (`isSingleColumn` равно `true`), возвращает полную ширину содержимого.
  /// В противном случае, ширина столбца вычисляется с учетом отступов между столбцами,
  /// позволяя корректно распределять ячейки в горизонтальном направлении.
  var columnWidth: CGFloat {
    let contentWidth = collectionViewContentSize.width
    let numberOfColumns = CGFloat(numberOfColumns)
    if isSingleColumn == true {
      return collectionViewContentSize.width
    }
    let columnWidth = (contentWidth - (numberOfColumns - 1) * itemSpacing) / numberOfColumns
    return columnWidth
  }
  
  // MARK: Private Properties
  private weak var delegate: (any CascadeLayoutDelegate)?
  
  /// Свойство `layoutAttributes` представляет собой
  /// массив объектов `UICollectionViewLayoutAttributes`,
  /// которые хранят информацию о позициях и размерах ячеек в макете.
  /// Оно инициализируется пустым массивом и используется для обновления и управления
  /// отображением ячеек в `UICollectionView` в соответствии с заданным макетом.
  private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
  
  /// Свойство `frames` представляет собой массив `CGRect`, который хранит координаты и размеры
  /// ячеек в макете. Оно инициализируется пустым массивом и используется для
  /// определения расположения каждой ячейки в `UICollectionView`, что позволяет
  /// точно управлять их отображением и компоновкой.
  private var frames: [CGRect] = []
  
  /// Свойство `pagingViewAttributes` хранит атрибуты `UICollectionViewLayoutAttributes`
  /// для представления с прокруткой (paging view). Инициализируется значением `nil`
  /// и используется для управления поведением и отображением прокручиваемого
  /// представления в `UICollectionView`, если таковое имеется.
  private var pagingViewAttributes: UICollectionViewLayoutAttributes?
  
  // MARK: Override Properties
  /// Переопределение свойства `collectionViewContentSize` возвращает размер содержимого
  /// `UICollectionView` в виде `CGSize`. Если `collectionView` не доступен, возвращает
  /// `CGSize.zero`. В противном случае, ширина устанавливается равной ширине `collectionView`,
  /// а высота - значению `contentHeight`, что позволяет корректно определить область прокрутки
  /// и отображение содержимого.
  override var collectionViewContentSize: CGSize {
    guard let collectionView = collectionView else {
      return CGSize.zero
    }
    let width = collectionView.frame.width
    return CGSize(
      width: width,
      height: contentHeight
    )
  }
  
  // MARK: Initializers
  /// Инициализатор `init(with:)` принимает делегата, реализующего протокол
  /// `CascadeLayoutDelegate`, и устанавливает его в свойство `delegate`.
  init(with delegate: (any CascadeLayoutDelegate)?) {
    self.delegate = delegate
    super.init()
    setUpDefaultOfColumns()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: Override Methods
  /// Переопределение метода `layoutAttributesForElements(in:)` возвращает массив
  /// атрибутов `UICollectionViewLayoutAttributes` для элементов, находящихся в
  /// заданном прямоугольнике `rect`.
  /// - Метод выполняет следующее:
  ///   - Инициализирует пустой массив `attributes` для хранения атрибутов.
  ///   - Находит первый индекс рамки, пересекающейся с `rect`.
  ///   - Находит последний индекс рамки, пересекающейся с `rect`,
  ///     обновляя `framesCount` для ограничения количества атрибутов.
  ///   - Добавляет атрибуты элементов в диапазоне от `firstFrameIndex` до `framesCount`.
  ///   - Если атрибуты прокручиваемого представления (`pagingViewAttributes`)
  ///     пересекаются с `rect`, добавляет их в массив атрибутов.
  ///     Метод возвращает массив атрибутов, которые будут использованы для отображения
  ///     ячеек в `UICollectionView`.
  override func layoutAttributesForElements(
    in rect: CGRect
  ) -> [UICollectionViewLayoutAttributes]? {
    var firstFrameIndex: Int = .zero
    var framesCount: Int = frames.count
    
    for index in .zero ..< framesCount where rect.intersects(frames[index]) {
      firstFrameIndex = index
      break
    }
    
    for index in (
      .zero ..< frames.count
    ).reversed() where rect.intersects(frames[index]) {
      framesCount = min((index + 1), layoutAttributes.count)
      break
    }
    
    for index in firstFrameIndex ..< framesCount {
      let attr = layoutAttributes[index]
      attributes.append(attr)
    }
    
    if let pagingViewAttributes = pagingViewAttributes,
       pagingViewAttributes.frame.intersects(rect) {
      attributes.append(pagingViewAttributes)
    }
    return attributes
  }
  
  /// Переопределение метода `layoutAttributesForItem(at:)` возвращает атрибуты
  /// `UICollectionViewLayoutAttributes` для ячейки по заданному `indexPath`.
  /// Метод извлекает атрибуты из массива `layoutAttributes` по индексу `item`
  /// и возвращает их, обеспечивая доступ к параметрам отображения для конкретной ячейки
  /// в `UICollectionView`.
  override func layoutAttributesForItem(
    at indexPath: IndexPath
  ) -> UICollectionViewLayoutAttributes? {
    return layoutAttributes[indexPath.item]
  }
  
  /// Метод `originForColumn(_:collectionView:columnHeights:)` вычисляет
  /// координаты `CGPoint` для начала столбца в зависимости от его индекса.
  /// Параметры:
  /// - `columnIndex`: индекс столбца, для которого вычисляется позиция.
  /// - `collectionView`: экземпляр `UICollectionView`, который может быть использован для
  /// получения дополнительных данных (можно использовать, если необходимо).
  /// - `columnHeights`: массив высот столбцов, который хранит текущее
  /// значение высоты каждого столбца.
  ///
  /// Метод возвращает `CGPoint`, где `x` вычисляется на основе индекса столбца
  /// и ширины столбца с учетом отступов, а `y` устанавливается равным высоте
  /// соответствующего столбца, что позволяет корректно размещать элементы
  /// в макете.
  func originForColumn(
    _ columnIndex: Int,
    collectionView: UICollectionView?,
    columnHeights: [CGFloat]
  ) -> CGPoint {
    let pointX = isSingleColumn ? .zero : CGFloat(columnIndex) * (columnWidth + itemSpacing)
    let pointY = columnHeights[columnIndex]
    return CGPoint(x: pointX, y: pointY)
  }
  
  /// Переопределение метода `shouldInvalidateLayout(forBoundsChange:)` определяет,
  /// нужно ли обновить макет при изменении границ `UICollectionView`.
  /// Метод проверяет, отличается ли ширина текущих границ `bounds` от новых границ `newBounds`.
  /// Если ширины разные, возвращает `true`, указывая на необходимость обновления макета,
  /// в противном случае возвращает `false`. Это позволяет динамически
  /// адаптировать макет к изменениям размеров `UICollectionView`.
  override func shouldInvalidateLayout(
    forBoundsChange newBounds: CGRect
  ) -> Bool {
    guard let bounds = collectionView?.bounds else {
      return false
    }
    return bounds.width != newBounds.width
  }
  
  /// Переопределение метода `prepare()` подготавливает макет для последующей отрисовки.
  /// - Этот метод выполняет следующиее:
  ///   - Вызывает `super.prepare()` для выполнения стандартной подготовки.
  ///   - Сбрасывает внутренние состояния с помощью метода `reset()`.
  ///   - Проверяет наличие `collectionView`, делегата и установленного количества столбцов.
  ///     Если что-то из этого отсутствует, выполнение метода прекращается.
  ///   - Инициализирует значения `itemSpacing`, `numberOfColumns` и `columnWidth`.
  ///   - Создает массив `columnHeights`, заполненный
  ///   значением `topInset`, для отслеживания высот столбцов.
  ///   - Подсчитывает общее количество элементов в `UICollectionView`.
  ///   - Определяет функцию `indexOfNextColumn()`,
  ///   которая находит индекс столбца с минимальной высотой.
  ///   - Для каждого элемента в `UICollectionView` вычисляет размер и положение ячейки:
  ///     - Создает `UICollectionViewLayoutAttributes` для текущей ячейки.
  ///     - Определяет индекс следующего столбца для размещения.
  ///     - Вычисляет положение ячейки с помощью метода `originForColumn(...)`.
  ///     - Получает размер ячейки, масштабируя его под ширину столбца.
  ///     - Обновляет высоту соответствующего столбца в массиве `columnHeights`.
  ///     - Устанавливает рамку для атрибутов ячейки и
  ///     добавляет их в массив `layoutAttributes` и `frames`.
  ///   - В конце обновляет `contentHeight`, устанавливая его равным максимальной высоте столбцов
  ///     плюс отступ между ячейками, что позволяет корректно задать высоту содержимого.
  override func prepare() {
    super.prepare()
    reset()
    
    guard
      let collectionView = collectionView,
      let delegate = delegate,
      self.numberOfColumns > .zero
    else {
      return
    }
    
    let itemSpacing = self.itemSpacing
    let numberOfColumns = self.numberOfColumns
    let columnWidth = self.columnWidth
    
    var columnHeights = [CGFloat](
      repeating: topInset,
      count: numberOfColumns
    )
    var numberOfItems: Int = .zero
    
    func indexOfNextColumn() -> Int {
      guard let minHeight = columnHeights.min() else {
        let zeroColumnHeight: Int = .zero
        return zeroColumnHeight
      }
      return columnHeights.firstIndex { $0 == minHeight } ?? .zero
    }
    
    (.zero ..< collectionView.numberOfSections).forEach {
      numberOfItems += collectionView.numberOfItems(inSection: $0)
    }
    
    for index in .zero ..< numberOfItems {
      let indexPath = IndexPath(item: index, section: .zero)
      let photoSize = delegate.cascadeLayout(sizeForItemAt: indexPath)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      let columnIndex = indexOfNextColumn()
      let origin = originForColumn(
        columnIndex,
        collectionView: collectionView,
        columnHeights: columnHeights
      )
      let newSize = self.scaledSizeForColumnWidth(from: photoSize, with: columnWidth)
      columnHeights[columnIndex] = origin.y + newSize.height + itemSpacing
      attributes.frame = CGRect(origin: origin, size: newSize)
      layoutAttributes.append(attributes)
      frames.append(attributes.frame)
    }
    contentHeight = columnHeights.max() ?? .zero
    contentHeight += itemSpacing
  }
  
  // MARK: Private Methods
  /// Метод `setUpDefaultOfColumns()` устанавливает количество столбцов в зависимости
  /// от типа устройства (iPad или iPhone).
  /// Он использует константы `Const.iPadColumns` и `Const.iPhoneColumns` для
  /// задания значений по умолчанию.
  /// Метод проверяет `userInterfaceIdiom` текущего устройства: если это iPad,
  /// устанавливает `numberOfColumns` равным значению для iPad, в противном случае
  /// устанавливает значение для iPhone. Это обеспечивает адаптивность макета
  /// для разных типов устройств.
  func setUpDefaultOfColumns() {
    let iPad = Const.iPadColumns
    let iPhone = Const.iPhoneColumns
    let userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
    let device = userInterfaceIdiom == .pad ? iPad : iPhone
    numberOfColumns = device
  }
  
  /// Метод `reset()` сбрасывает состояние макета к значениям по умолчанию.
  ///
  /// Метод выполняет следующее:
  ///   - Устанавливает `pagingViewAttributes` в `nil`, освобождая память,
  ///     если атрибуты прокручиваемого представления больше не нужны.
  ///   - Очищает массив `layoutAttributes`, удаляя все ранее сохраненные атрибуты ячеек.
  ///   - Очищает массив `frames`, удаляя все сохраненные рамки элементов.
  ///   - Устанавливает `contentHeight` в ноль, подготавливая макет к новому расчету
  ///     высоты содержимого при следующем обновлении.
  func reset() {
    pagingViewAttributes = nil
    layoutAttributes.removeAll()
    frames.removeAll()
    contentHeight = .zero
  }
  
  // MARK: Utilities
  /// Масштабирует размеры элемента на основе заданной ширины столбца.
  ///
  /// Параметры:
  /// - `originalSize`: исходный размер элемента, который необходимо масштабировать,
  /// - `columnWidth`: желаемая ширина столбца.
  ///
  /// Метод вычисляет новую высоту элемента, пропорционально изменяя исходную
  /// высоту с использованием коэффициента ширины, и возвращает новый размер
  /// в формате `CGSize`. Значения ширины и высоты округляются вниз с помощью
  /// функции `floor()`, что предотвращает возникновение дробных значений и
  /// обеспечивает корректное отображение в макете.
  private func scaledSizeForColumnWidth(
    from originalSize: CGSize,
    with columnWidth: CGFloat
  ) -> CGSize {
    let height = originalSize.height * columnWidth / originalSize.width
    return CGSize(width: floor(columnWidth), height: floor(height))
  }
}
