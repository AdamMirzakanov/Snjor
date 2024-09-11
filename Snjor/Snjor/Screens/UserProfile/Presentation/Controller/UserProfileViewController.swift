//
//  UserProfileViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 10.09.2024.
//

import UIKit
import Combine

class UserProfileViewController: MainViewController<UserProfileViewControllerRootView> {
  // MARK: Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var viewModel: any UserProfileViewModelProtocol
  
  // MARK: Initializers
  init(
    viewModel: any UserProfileViewModelProtocol
  ) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    stateController()
    viewModel.viewDidLoad()
    rootView.backgroundColor = .systemBackground
  }
  
  deinit {
    print(#function, Self.self, "🟤")
  }
  
  // MARK: Private Methods
  private func stateController() {
    viewModel
      .state
      .receive(on: RunLoop.current)
      .sink { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .success:
          rootView.setupData(viewModel: viewModel)
        case .loading: break
        case .fail(error: let error):
          presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }
}
