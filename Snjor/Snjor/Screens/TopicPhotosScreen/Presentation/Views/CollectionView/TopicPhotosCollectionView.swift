//
//  TopicPhotosCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

final class TopicPhotosCollectionView: BaseCollectionView {
  override func cellRegister() {
    register(
      TopicPhotoCell.self,
      forCellWithReuseIdentifier: TopicPhotoCell.reuseID
    )
  }
}
