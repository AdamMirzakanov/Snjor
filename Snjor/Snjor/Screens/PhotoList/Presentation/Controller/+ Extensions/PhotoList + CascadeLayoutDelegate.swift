//
//  PhotoList + CascadeLayoutDelegate.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Foundation

extension PhotoListCollectionViewController: CascadeLayoutDelegate {
  func cascadeLayout(
    _ layout: CascadeLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let photo = viewModel.getPhoto(at: indexPath.item)
    return CGSize(width: photo.width, height: photo.height)
  }
}
