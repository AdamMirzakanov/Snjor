//
//  PageScreenTopicPhotosFactoryProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 15.08.2024.
//

import UIKit

protocol PageScreenTopicPhotosFactoryProtocol {
  func makeModule(
    delegate: any PageScreenTopicPhotosViewControllerDelegate
  ) -> UIViewController
}