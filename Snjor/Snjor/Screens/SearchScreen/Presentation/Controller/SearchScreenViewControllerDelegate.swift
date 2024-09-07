//
//  SearchScreenViewControllerDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 04.09.2024.
//

protocol SearchScreenViewControllerDelegate: AnyObject {
  func photoCellDidSelect(_ photo: Photo)
  func topicCellDidSelect(_ topic: Topic)
  func albumCellDidSelect(_ album: Album)
  func searchButtonClicked(with searchTerm: String, currentScopeIndex: Int)
  func tagCellDidSelect(
    _ tag: Tag,
    with searchTerm: String,
    currentScopeIndex: Int
  )
}
