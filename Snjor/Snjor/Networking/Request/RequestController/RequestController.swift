//
//  RequestController.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

import Foundation

/// `RequestController` управляет формированием запросов к API для получения
/// различных данных, таких как фотографии, альбомы, пользователи топики и т.д.
final class RequestController {
  var photos: Endpoints { .photos }
  var topics: Endpoints { .topics }
  var searchPhotos: Endpoints { .searchPhotos }
  var albums: Endpoints { .collections }
  var searchCollections: Endpoints { .searchCollections }
  var searchUsers: Endpoints { .searchUsers }
  var userProfile: Endpoints { .userProfile }
  
  let networkRequestService = NetworkRequestService()
}
