//
//  UserProfileViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

import Foundation

struct UserProfileViewModelItem {
  var user: User
  var photo: Photo
  
  var displayName: String {
    user.displayName
  }
  
  var userBio: String {
    user.bio ?? .empty
  }
  
  var totalLikes: String {
    String(user.totalLikes)
  }
  
  var totalPhotos: String {
    String(user.totalPhotos)
  }
  
  var totalCollections: String {
    String(user.totalCollections)
  }
  
  var location: String {
    user.location ?? .empty
  }
  
  var photoURL: URL? {
    photo.regularURL
  }
}
