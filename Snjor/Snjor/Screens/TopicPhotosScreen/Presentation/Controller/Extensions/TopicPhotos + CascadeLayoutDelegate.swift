//
//  TopicPhotos + CascadeLayoutDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import Foundation

extension TopicPhotosViewController: CascadeLayoutDelegate {
  func cascadeLayout(
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let photo = viewModel.getItem(at: indexPath.item)
    return CGSize(width: photo.width, height: photo.height)
  }
}
