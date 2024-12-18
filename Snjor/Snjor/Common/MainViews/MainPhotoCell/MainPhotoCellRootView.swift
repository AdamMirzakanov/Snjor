//
//  MainPhotoCellRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

final class MainPhotoCellRootView: BaseView {
  // MARK: Main View
  let mainView: MainPhotoCellView = {
    return $0
  }(MainPhotoCellView())
  
  // MARK: Setup Views
  override func initViews() {
    addSubview(mainView)
    mainView.fillSuperView()
  }
}
