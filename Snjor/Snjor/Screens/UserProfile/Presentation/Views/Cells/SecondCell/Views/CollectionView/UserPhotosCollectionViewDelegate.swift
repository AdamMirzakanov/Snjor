//
//  UserPhotosCollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 21.09.2024.
//

import Foundation

protocol UserPhotosCollectionViewDelegate: AnyObject {
  func collectionViewDidSelectItem(at indexPath: IndexPath)
}
