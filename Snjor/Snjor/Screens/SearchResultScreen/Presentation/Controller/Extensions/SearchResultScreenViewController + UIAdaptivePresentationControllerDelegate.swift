//
//  SearchResultScreenViewController + UIAdaptivePresentationControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.08.2024.
//

import UIKit

extension SearchResultScreenViewController: UIAdaptivePresentationControllerDelegate {
  func presentationControllerDidDismiss(
    _ presentationController: UIPresentationController
  ) {
    resetSearchState()
    navigationController?.viewControllers.removeAll { $0 === self }
  }
}
