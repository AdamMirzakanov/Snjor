//
//  AlbumPhotosViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 04.09.2024.
//

protocol AlbumPhotosViewControllerDelegate: AnyObject {
  func didSelect(_ photo: Photo)
}
