//
//  PhotoListContainerView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

class PhotoListContainerView: UIView {
  
  let photoListCollectionView: PhotosCollectionView = {
    return $0
  }(PhotosCollectionView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(photoListCollectionView)
  }
  
  private func setupConstraints() {
    photoListCollectionViewConstraints()
  }
  
  private func photoListCollectionViewConstraints() {
    photoListCollectionView.fillSuperView()
  }
  
}

final class PhotosCollectionView: UICollectionView {
  // MARK: - Private Properties
  private let flowlayout = UICollectionViewFlowLayout()
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero, collectionViewLayout: flowlayout)
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
    showsHorizontalScrollIndicator = false
  }
  
  private func cellRegister() {
    register(
      PhotoListCell.self,
      forCellWithReuseIdentifier: PhotoListCell.reuseID
    )
  }
}
