//
//  UserProfileViewModelItem.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 11.09.2024.
//

struct UserProfileViewModelItem {
  var user: User
  
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
  
  var instagramUserName: String {
    user.social?.instagramUsername ?? .empty
  }
  
  var twitterUsername: String {
    user.social?.twitterUsername ?? .empty
  }
}
