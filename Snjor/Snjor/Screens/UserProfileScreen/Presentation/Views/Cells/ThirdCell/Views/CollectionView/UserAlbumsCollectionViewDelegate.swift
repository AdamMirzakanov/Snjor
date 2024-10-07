//
//  UserAlbumsCollectionViewDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.09.2024.
//

import Foundation

protocol UserAlbumsCollectionViewDelegate: AnyObject {
  func collectionViewDidSelectItem(at indexPath: IndexPath)
}
