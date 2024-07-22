//
//  Topic.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import Foundation

struct Topic: Decodable {
  let id: String
  let title: String
//  let description: String
//  let coverPhoto: CoverPhoto
  
//  private enum CodingKeys: String, CodingKey {
//    case id
//    case title
//    case description
//    case coverPhoto = "cover_photo"
//  }
//  
//  init(from decoder: Decoder) throws {
//    
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    
//    // декодирование свойств
//    id = try container.decode(String.self, forKey: .id)
//    title = try container.decode(String.self, forKey: .title)
//    description = try container.decode(String.self, forKey: .description)
//    coverPhoto = try container.decode(CoverPhoto.self, forKey: .coverPhoto)
//  }
//  
//  struct CoverPhoto: Decodable {
//    
//    let urls: [URLKind: URL]
//    
//    enum URLKind: String, Decodable, CodingKey {
//      case raw
//      case full
//      case regular
//      case small
//      case thumb
//    }
//    
//    private enum CodingKeys: String, CodingKey {
//      case urls
//    }
//    
//    init(from decoder: Decoder) throws {
//      let container = try decoder.container(keyedBy: CodingKeys.self)
//      let urlsContainer = try container.nestedContainer(
//        keyedBy: URLKind.self,
//        forKey: .urls
//      )
//      urls = try urlsContainer.allKeys.reduce(into: [:]) { result, key in
//        if let kind = URLKind(rawValue: key.rawValue),
//           let url = try urlsContainer.decodeIfPresent(URL.self, forKey: key) {
//          result[kind] = url
//        }
//      }
//    }
//  }
}
