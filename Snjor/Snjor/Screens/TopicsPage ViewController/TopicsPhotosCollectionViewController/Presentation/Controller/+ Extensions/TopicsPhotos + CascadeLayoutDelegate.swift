//
//  TopicsPhotos + CascadeLayoutDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

import Foundation

extension TopicsPhotosCollectionViewController: CascadeLayoutDelegate {
  func cascadeLayout(
    _ layout: CascadeLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let photo = viewModel.getPhoto(at: indexPath.item)
    return CGSize(width: photo.width, height: photo.height)
  }
}
