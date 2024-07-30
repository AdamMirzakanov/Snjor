//
//  TopicsPagePhotoListCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 30.07.2024.
//

import UIKit

final class TopicsPagePhotoListCell: UICollectionViewCell {
  // MARK: - Main View
  let mainView: TopicPhotoListCellMainView = {
    return $0
  }(TopicPhotoListCellMainView())
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupPhotoView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Override Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    mainView.prepareForReuse()
  }

  // MARK: - Setup Data
  func configure(viewModelItem: TopicPhotoListViewModelItem) {
    let photo = viewModelItem.photo
    let photoURL = viewModelItem.photoURL
    mainView.configure(with: photo, url: photoURL)
  }

  // MARK: - Setup Views
  private func setupPhotoView() {
    contentView.addSubview(mainView)
    mainView.fillSuperView()
  }
}
