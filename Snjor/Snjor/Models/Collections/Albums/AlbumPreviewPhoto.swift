//
//  AlbumPreviewPhoto.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 09.08.2024.
//

struct AlbumPreviewPhoto: Decodable, Hashable {
  let slug: String
  let blurHash: String?
  let urls: AlbumPreviewPhotoURL
}
