//
//  SearchResultScreenViewController + CascadeLayoutDelegate.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.08.2024.
//

import Foundation

extension SearchResultScreenViewController: CascadeLayoutDelegate {
  func cascadeLayout(
    _ layout: any CascadeLayoutConformable,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let photo = photosViewModel.getItem(at: indexPath.item)
    return CGSize(width: photo.width, height: photo.height)
  }
}
