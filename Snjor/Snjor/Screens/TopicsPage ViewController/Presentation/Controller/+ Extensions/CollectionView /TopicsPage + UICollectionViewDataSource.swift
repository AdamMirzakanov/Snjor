//
//  TopicsPage + UICollectionViewDataSource.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

// MARK: - UICollectionViewDataSource
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
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TopicsCell.reuseID,
      for: indexPath
    ) as! TopicsCell
    let topic = viewModel.topics[indexPath.item]
    cell.configure(with: topic)
    return cell
  }
  
  
}
