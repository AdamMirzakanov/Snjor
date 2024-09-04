//
//  ParentCoordinator.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

protocol ParentCoordinator: AnyObject {
  var childCoordinators: [any Coordinatable] { get set }
}

// MARK: - Default method implementation
extension ParentCoordinator {
  func addAndStartChildCoordinator(
_ coordinator: (any Coordinatable)?
  ) {
    guard let childCoordinator = coordinator else { return }
    childCoordinators.append(childCoordinator)
    childCoordinator.start()
  }

  func removeChildCoordinator(_ coordinator: any Coordinatable) {
    childCoordinators = childCoordinators.filter { $0 !== coordinator }
  }

  func clearAllChildCoordinators() {
    childCoordinators = []
  }
}
