//
//  PageScreenTopicPhotosFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

protocol PageScreenTopicPhotosFactoryProtocol {
  func makeController(
    delegate: any PageScreenPhotosViewControllerDelegate
  ) -> UIViewController
}
