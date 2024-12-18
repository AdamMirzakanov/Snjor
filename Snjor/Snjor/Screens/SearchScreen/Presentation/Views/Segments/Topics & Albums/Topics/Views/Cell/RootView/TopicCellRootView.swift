//
//  TopicCellRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

final class TopicCellRootView: BaseView {
  // MARK: Views
  let mainView: TopicCellMainView = {
    return $0
  }(TopicCellMainView())
  
  // MARK: Initializers
  override func initViews() {
    setupMainView()
  }
  
  // MARK: Setup Views
  private func setupMainView() {
    addSubview(mainView)
    mainView.fillSuperView()
  }
}
