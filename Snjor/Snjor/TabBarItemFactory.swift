//
//  TabBarItemFactory.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

import UIKit

protocol TabBarItemFactory { }

extension TabBarItemFactory {
  func makeTabBarItem(
    navigation: Navigable,
    title: String,
    systemImageName imageName: String,
    selectedSystemImageName selectedImageName: String
  ) {
    let tabBarItem = UITabBarItem(
      title: title,
      image: UIImage(systemName: imageName),
      selectedImage: UIImage(systemName: selectedImageName)
    )
    navigation.rootViewController.tabBarItem = tabBarItem
  }
}
