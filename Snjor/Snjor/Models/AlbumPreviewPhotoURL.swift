//
//  AlbumPreviewPhotoURL.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import Foundation

struct AlbumPreviewPhotoURL: Decodable, Hashable {
  let raw: URL
  let full: URL
  let thumb: URL
  let smallS3: URL
  let regular: URL
  let small: URL
}
