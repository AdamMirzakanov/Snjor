//
//  ParentCoordinator.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

/// Протокол `ParentCoordinator` определяет требования для координаторов,
/// которые могут управлять дочерними координаторами.
protocol ParentCoordinator: AnyObject {
  /// Массив дочерних координаторов, которыми управляет родительский координатор.
  var childCoordinators: [any Coordinatable] { get set }
}

// MARK: - Default method implementation
extension ParentCoordinator {
  /// Добавляет дочерний координатор в массив и запускает его.
  /// - Parameter coordinator: Дочерний координатор, который нужно добавить и запустить.
  func addAndStartChildCoordinator(
    _ coordinator: (any Coordinatable)?
  ) {
    guard let childCoordinator = coordinator else { return }
    childCoordinators.append(childCoordinator)
    childCoordinator.start()
  }
  
  /// Удаляет указанного дочернего координатора из массива.
  /// - Parameter coordinator: Дочерний координатор, который нужно удалить.
  func removeChildCoordinator(_ coordinator: any Coordinatable) {
    childCoordinators = childCoordinators.filter { $0 !== coordinator }
  }
  
  /// Очищает массив дочерних координаторов, удаляя всех дочерних координаторов.
  func clearAllChildCoordinators() {
    childCoordinators = []
  }
}
