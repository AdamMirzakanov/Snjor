//
//  AlbumsCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

final class AlbumsCollectionView: UICollectionView {
  // MARK: - Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    configureLayout()
    cellRegister()
    reusableViewRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  private func configureLayout() {
    flowlayout.scrollDirection = .vertical
    backgroundColor = .clear
  }
  
  private func cellRegister() {
    register(
      AlbumCell.self,
      forCellWithReuseIdentifier: AlbumCell.reuseID
    )
    register(
      TopicCell.self,
      forCellWithReuseIdentifier: TopicCell.reuseID
    )
  }
  
  private func reusableViewRegister() {
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
