//
//  SearchScreenViewControllerConst.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 03.09.2024.
//

import Foundation

extension Int {
  static let discover = 0
  static let topicAndAlbums = 1
}

enum SearchScreenViewControllerConst {
  static var discoverTitle: String {
    Key.discoverTitle.localizeString()
  }
  static var topicsAndAlbumsTitle: String {
    Key.topicsAndAlbumsTitle.localizeString()
  }
  static var usersTitle: String {
    Key.usersTitle.localizeString()
  }
  static var searchPhotos: String {
    Key.searchPhotos.localizeString()
  }
  static var searchAlbums: String {
    Key.searchAlbums.localizeString()
  }
  static var searchUsers: String {
    Key.searchUsers.localizeString()
  }
  static var initialUserSearchQuery: String {
    Key.initialUserSearchQuery.localizeString()
  }
  
  static var albumsSectionName: String {
    Key.albumsSectionName.localizeString()
  }
}

// MARK: - Localizable Keys
private enum Key: String, CaseIterable {
  case discoverTitle = "discover_Title_Key"
  case topicsAndAlbumsTitle = "topics_AndAlbums_Title_Key"
  case usersTitle = "users_Title_Key"
  case searchPhotos = "search_Photos_Key"
  case searchAlbums = "search_Albums_Key"
  case searchUsers = "search_Users_Key"
  case initialUserSearchQuery = "initial_User_Search_Query_Key"
  case albumsSectionName = "albums_Section_Name_Key"
  
  func localizeString() -> String {
    NSLocalizedString(self.rawValue, comment: .empty )
  }
}
