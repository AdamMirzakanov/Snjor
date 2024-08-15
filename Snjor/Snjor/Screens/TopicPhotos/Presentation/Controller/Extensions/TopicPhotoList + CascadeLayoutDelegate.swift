//
//  TopicPhotoList + CascadeLayoutDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 25.07.2024.
//

import Foundation

extension TopicPhotosViewController: CascadeLayoutDelegate {
  func cascadeLayout(
    _ layout: any CascadeLayoutConformable,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let photo = viewModel.getPhoto(at: indexPath.item)
    return CGSize(width: photo.width, height: photo.height)
  }
}
