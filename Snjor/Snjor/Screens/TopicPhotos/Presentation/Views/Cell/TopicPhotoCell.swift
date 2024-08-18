//
//  TopicPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

protocol TopicPhotoCellDelegate: AnyObject {
  func downloadTapped(_ cell: TopicPhotoCell)
}

final class TopicPhotoCell: UICollectionViewCell {
  
  // MARK: - Delegate
  weak var delegate: (any TopicPhotoCellDelegate)?

  // MARK: - Main View
  let mainView: TopicPhotoCellMainView = {
    return $0
  }(TopicPhotoCellMainView())
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupMainView()
    mainView.delegate = self
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
  func configure(viewModelItem: TopicPhotosViewModelItem) {
    let photo = viewModelItem.photo
    let photoURL = viewModelItem.photoURL
    mainView.configure(with: photo, url: photoURL)
  }

  // MARK: - Setup Views
  private func setupMainView() {
    contentView.addSubview(mainView)
    mainView.fillSuperView()
  }
}
