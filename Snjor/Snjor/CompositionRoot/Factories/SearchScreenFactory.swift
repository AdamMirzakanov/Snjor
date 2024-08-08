//
//  SearchScreenFactory.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 07.08.2024.
//

import UIKit
import Combine

protocol SearchScreenFactoryProtocol {
//  func makeTabBarItem(navigation: any Navigable)
  func makeModule() -> UIViewController
}

struct SearchScreenFactory: SearchScreenFactoryProtocol {
//  func makeTabBarItem(navigation: any Navigable) {
//    //code:
//  }
  
  func makeModule() -> UIViewController {
    let module = SearchScreenViewController()
    return module
  }
}
