//
//  TopicsPageViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import UIKit

protocol TopicsPageViewModelProtocol: BaseViewModelProtocol {
  var topicsCount: Int { get }
  func getTopic(at index: Int) -> Topic
  func getTopicsPageViewModelItem(at index: Int) -> TopicsPageViewModelItem
  func applySnapshot()
  func createDataSource(for collectionView: UICollectionView)
}
