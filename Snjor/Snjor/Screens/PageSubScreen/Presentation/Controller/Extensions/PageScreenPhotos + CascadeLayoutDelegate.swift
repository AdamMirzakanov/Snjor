//
//  PageScreenTopicPhotos + CascadeLayoutDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import Foundation

extension PageScreenPhotosViewController: CascadeLayoutDelegate {
  func cascadeLayout(
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let photo = viewModel.getItem(at: indexPath.item)
    return CGSize(width: photo.width, height: photo.height)
  }
}
