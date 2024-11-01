//
//  PageScreenViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit
import Combine

final class PageScreenViewController: MainViewController<PageScreenRootView> {
  // MARK: Internal Properties
  var topicsDataSource: TopicsDataSource?
  
  // MARK: Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var viewModel: any ContentManagingProtocol<Topic>
  private(set) var coordinator: any PageScreenPhotosViewControllerDelegate
  
  // MARK: Initializers
  init(
    viewModel: any ContentManagingProtocol<Topic>,
    coordinator: any PageScreenPhotosViewControllerDelegate
  ) {
    self.viewModel = viewModel
    self.coordinator = coordinator
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError(AppLocalized.initCoderNotImplementedError)
  }
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDataSource()
    setFirstPage()
    configPageViewController()
    configTopicsCollectionView()
    viewModel.viewDidLoad()
    stateController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationBarHidden(true, animated: animated)
    showCustomTabBar()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    // Обновление индикатора до начальной позиции после изменения расположения подвидов.
    updateIndicatorToInitialPosition()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    setNavigationBarHidden(false, animated: animated)
  }
  
  // MARK: Internal Methods
  /// Возвращает контроллер для отображения фотографий определенного топика.
  /// - Parameters:
  ///   - index: Индекс топика, для которогор требуется создать контроллер.
  ///   - delegate: Делегат, реализующий `PageScreenPhotosViewControllerDelegate`.
  /// - Returns: Контроллер `UIViewController?`, представляющий выбранный топик, или `nil`,
  /// если индекс выходит за пределы допустимых значений.
  func viewControllerForTopic(
    at index: Int,
    delegate: any PageScreenPhotosViewControllerDelegate
  ) -> UIViewController? {
    
    // Проверка, что индекс находится в допустимом диапазоне.
    guard
      index >= .zero,
      index < viewModel.items.count else {
      return nil
    }
    
    // Получение элемента ViewModel по индексу.
    let topicsPageViewModelItem = viewModel.getViewModelItem(at: index)
    
    // Получение объекта топика и фабрики для создания контроллера.
    let topic = topicsPageViewModelItem.item
    let topicPhotoListFactory = PageScreenTopicPhotosFactory(topic: topic)
    
    // Получение идентификатора топика.
    let topicID = topicsPageViewModelItem.itemID
    
    // Создание контроллера с помощью фабрики.
    let viewController = topicPhotoListFactory.makeController(delegate: coordinator)
    
    // Проверка, является ли созданный контроллер
    // типом `PageScreenPhotosViewController`.
    guard let topicPhotoListCollectionViewController = (
      viewController as? PageScreenPhotosViewController
    ) else {
      // Возврат базового контроллера, если тип не совпал.
      return viewController
    }
    
    // Настройка свойств контроллера с идентификатором топика и индексом.
    topicPhotoListCollectionViewController.topicID = topicID
    topicPhotoListCollectionViewController.pageIndex = index
    
    // Возврат настроенного контроллера.
    return topicPhotoListCollectionViewController
  }
  
  // MARK: Private Methods
  private func setupDataSource() {
    createDataSource(
      for: rootView.topicsCollectionView
    )
  }
  
  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          applySnapshot()
          setFirstPage()
        case .loading: break
        case .fail(error: let error):
          showError(error: error)
        }
      }
      .store(in: &cancellable)
  }
  
  /// Устанавливает первый экран в качестве текущего для `pageViewController`.
  /// Метод получает контроллер для первого топика и устанавливает его как первый отображаемый контроллер.
  /// Если контроллер не удается создать, метод ничего не делает.
  private func setFirstPage() {
    // Получение контроллера для первой страницы с проверкой на существование.
    guard
      let firstPage = self.viewControllerForTopic(at: .zero, delegate: coordinator)
    else {
      return
    }
    
    // Установка первого контроллера в `pageViewController` с анимацией.
    rootView.pageViewController.setViewControllers(
      [firstPage],
      direction: .forward,
      animated: true
    )
  }
  
  private func configPageViewController() {
    rootView.pageViewController.dataSource = self
    rootView.pageViewController.delegate = self
    addChild(rootView.pageViewController)
    rootView.pageViewController.didMove(toParent: self)
    rootView.backgroundColor = .systemBackground
  }
  
  private func configTopicsCollectionView() {
    rootView.topicsCollectionView.delegate = self
  }
  
  private func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
    self.navigationController?.setNavigationBarHidden(hidden, animated: animated)
  }
  
  /// Устанавливает индикатор на первую ячейку топика.
  ///
  /// Метод находит первую ячейку коллекции и устанавливает индикатор в её положение.
  /// Если первая ячейка не найдена, метод ничего не делает.
  /// - Note: Метод следует вызываеть в `viewDidLayoutSubviews()`
  /// так как в других методах жизненого цикла индикатор при первом запуске проекта может не отобразится
  private func updateIndicatorToInitialPosition() {
    // Создание `IndexPath` для первого элемента.
    let firstItemIndexPath = IndexPath(item: .zero, section: .zero)
    
    // Получение первой ячейки коллекции с проверкой на существование.
    guard
      let cell = rootView.topicsCollectionView.cellForItem(at: firstItemIndexPath)
    else {
      return
    }
    
    // Обновление позиции индикатора для найденной ячейки.
    rootView.topicsCollectionView.updateIndicatorPosition(for: cell)
  }
}
