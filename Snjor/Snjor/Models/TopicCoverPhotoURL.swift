//
//  TopicCoverPhotoURL.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 13.08.2024.
//

import Foundation

struct TopicCoverPhotoURL: Decodable, Hashable {
    let raw: URL
    let full: URL
    let regular: URL
    let small: URL
    let thumb: URL
}
