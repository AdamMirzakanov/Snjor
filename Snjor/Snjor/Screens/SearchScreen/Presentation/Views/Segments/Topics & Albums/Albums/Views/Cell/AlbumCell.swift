//
//  AlbumCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 08.08.2024.
//

import UIKit

final class AlbumCell: BaseColletionViewCell<AlbumCellRootView> {
  // MARK: Internal Properties
  weak var delegate: (any AlbumCellDelegate)?
 
  // MARK: Override Methods
  override func setupDelegate() {
    rootView.tagsCollectionView.tagsDelegate = self
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    rootView.mainView.prepareForReuse()
    rootView.tagsCollectionView.tags = []
    rootView.tagsCollectionView.reloadData()
  }
  
  // MARK: Setup Data
  func configure(viewModelItem: BaseViewModelItem<Album> ) {
    let album = viewModelItem.item
    let coverPhotoURL = viewModelItem.photoURL
    rootView.mainView.configure(with: album, url: coverPhotoURL)
    rootView.tagsCollectionView.tags = album.tags ?? []
  }
}
