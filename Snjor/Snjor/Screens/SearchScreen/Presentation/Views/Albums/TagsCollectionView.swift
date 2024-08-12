//
//  TagsCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.08.2024.
//

import UIKit

final class TagsCollectionView: UICollectionView {
  
  // MARK: - Internal Properties
  var tags: [Tag] = []
  
  // MARK: - Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
    delegate = self
    dataSource = self
    configureLayout()
    cellRegister()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Methods
  private func configureLayout() {
    flowlayout.scrollDirection = .horizontal
    backgroundColor = .clear
    bounces = false
    showsHorizontalScrollIndicator = false
  }
  
  private func cellRegister() {
    register(
      TagCell.self,
      forCellWithReuseIdentifier: TagCell.reuseID
    )
  }
}

extension TagsCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tags.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseID, for: indexPath) as! TagCell
    cell.configure(with: tags[indexPath.item])
    return cell
  }
}

extension TagsCollectionView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let itemIndex = indexPath.item
    let width = calculateItemWidth(for: itemIndex)
    return CGSize(
      width: width,
      height: collectionView.bounds.height
    )
  }
  
  // MARK: -  Private Methods
  private func calculateItemWidth(for index: Int) -> CGFloat {
    let tag = tags[index]
    let width = tag.title.size(
      withAttributes: [
        NSAttributedString
          .Key
          .font: UIFont.systemFont(ofSize: 13)
      ]
    ).width + 20
    return width
  }
}
