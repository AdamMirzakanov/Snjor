//
//  Topic.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

struct Topic: Decodable, Hashable {
  let id: String
  let title: String
  let description: String
  let coverPhoto: TopicCoverPhoto
}
