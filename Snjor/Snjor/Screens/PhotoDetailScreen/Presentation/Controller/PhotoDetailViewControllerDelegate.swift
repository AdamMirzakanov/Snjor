//
//  PhotoDetailViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 05.09.2024.
//

protocol PhotoDetailViewControllerDelegate: AnyObject {
  func tagCellDidSelect(
    _ tag: Tag,
    with searchTerm: String,
    currentScopeIndex: Int
  )
  
  func didRequestProfileScreen(_ user: User)
}
