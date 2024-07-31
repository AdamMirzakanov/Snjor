//
//  TopicsPage + UICollectionViewDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

extension TopicsPageViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return viewModel.topicsCount
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: TopicsPageCategoryCell.reuseID,
        for: indexPath
      ) as? TopicsPageCategoryCell
    else {
      return UICollectionViewCell()
    }
    
    let itemIndex = indexPath.item
    let topicsPageViewModelItem = viewModel.getTopicsPageViewModelItem(at: itemIndex)
    cell.configure(viewModelItem: topicsPageViewModelItem)
    return cell
  }
}

