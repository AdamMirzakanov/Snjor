//
//  TopicPhotoListCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 01.08.2024.
//

import UIKit

final class TopicPhotoListCollectionView: UICollectionView {
  // MARK: - Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    cellRegister()
//    headerRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  private func cellRegister() {
    register(
      TopicsPagePhotoListCell.self,
      forCellWithReuseIdentifier: TopicsPagePhotoListCell.reuseID
    )
  }
  
//  private func headerRegister() {
//    register(
//      SectionHeaderView.self,
//      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//      withReuseIdentifier: SectionHeaderView.reuseID
//    )
//  }
}
