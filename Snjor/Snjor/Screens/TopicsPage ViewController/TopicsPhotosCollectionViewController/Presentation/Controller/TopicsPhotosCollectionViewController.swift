//
//  TopicsPhotosCollectionViewController.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

class TopicsPhotosCollectionViewController: UICollectionViewController {
  
  var topicID: String?
  var pageIndex: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    print(#function, "TopicsPhotosCollectionViewController")
  }
  
  private func setupCollectionView() {
    collectionView.register(
      TopicsPhotosCollectionViewController.self,
      forCellWithReuseIdentifier: PhotoCell.reuseID
    )
  }
  
}
