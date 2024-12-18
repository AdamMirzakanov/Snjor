//
//  TopicsAndAlbumsCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

final class TopicsAndAlbumsCollectionView: BaseCollectionView {
  override func cellRegister() {
    register(
      AlbumCell.self,
      forCellWithReuseIdentifier: AlbumCell.reuseID
    )
    register(
      TopicCell.self,
      forCellWithReuseIdentifier: TopicCell.reuseID
    )
  }
  
  override func reusableViewRegister() {
    register(
      SectionHeaderView.self,
      forSupplementaryViewOfKind: SupplementaryViewKind.header,
      withReuseIdentifier: SectionHeaderView.reuseID
    )
    register(
      LineView.self,
      forSupplementaryViewOfKind: SupplementaryViewKind.line,
      withReuseIdentifier: LineView.reuseID
    )
  }
}
