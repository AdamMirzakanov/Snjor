//
//  PageScreenPhotoCellRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import UIKit

final class PageScreenPhotoCellRootView: BaseView {
  // MARK: Views
  let mainView: PageScreenPhotoCellMainView = {
    return $0
  }(PageScreenPhotoCellMainView())
  
  // MARK: Initializers
  override func initViews() {
    addSubview(mainView)
    mainView.fillSuperView()
  }
}
