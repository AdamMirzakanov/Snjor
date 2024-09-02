//
//  OldTopicsViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import UIKit

protocol OldTopicsViewModelProtocol: BaseViewModelProtocol {
  var topicsCount: Int { get }
  func getTopic(at index: Int) -> Topic
  func getTopicsPageViewModelItem(at index: Int) -> OldTopicsViewModelItem
  func applySnapshot()
  func createDataSource(for collectionView: UICollectionView)
}
