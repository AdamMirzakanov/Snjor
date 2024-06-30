//
//  + WaterfallLayoutDelegate.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Foundation

extension PhotoListCollectionViewController: WaterfallLayoutDelegate {
  func waterfallLayout(
    _ layout: WaterfallLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let photo = viewModel.getPhotoItem(at: indexPath.item)
    return CGSize(width: photo.width, height: photo.height)
  }
}
