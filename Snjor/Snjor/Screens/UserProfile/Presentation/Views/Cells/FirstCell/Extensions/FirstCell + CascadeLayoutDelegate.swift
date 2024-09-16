//
//  FirstCell + CascadeLayoutDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 16.09.2024.
//

import Foundation

extension FirstCell: CascadeLayoutDelegate {
  func cascadeLayout(
    _ layout: any CascadeLayoutConformable,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    guard let viewModel = userLikedPhotosViewModel else { return .zero }
    let photo = viewModel.getItem(at: indexPath.item)
    return CGSize(width: photo.width, height: photo.height)
  }
}
