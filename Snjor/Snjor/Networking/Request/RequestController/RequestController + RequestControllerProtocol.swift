//
//  RequestController + RequestControllerProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import Foundation

extension RequestController: RequestControllerProtocol {
  func photosRequest() throws -> URLRequest {
    let path = photos.rawValue
    let parameters = PrepareParameters.preparePhotosParameters()
    let request = try networkRequestService.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  func albumsRequest() throws -> URLRequest {
    let path = albums.rawValue
    let parameters = PrepareParameters.prepareAlbumParameters()
    let request = try networkRequestService.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  func searchPhotosRequest(with searchTerm: String) throws -> URLRequest {
    let path = searchPhotos.rawValue
    let parameters = PrepareParameters.prepareSearchPhotoParameters(with: searchTerm)
    let request = try networkRequestService.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  func searchAlbumsRequest(with searchTerm: String) throws -> URLRequest {
    let path = searchCollections.rawValue
    let parameters = PrepareParameters.prepareSearchAlbumsParameters(with: searchTerm)
    let request = try networkRequestService.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  func searchUsersRequest(with searchTerm: String) throws -> URLRequest {
    let path = searchUsers.rawValue
    let parameters = PrepareParameters.prepareSearchUsersParameters(with: searchTerm)
    let request = try networkRequestService.prepareAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  func photoDetailRequest(photo: Photo) throws -> URLRequest {
    let path = photos.rawValue
    let id = photo.id
    let request = try networkRequestService.preparePhotoInfoAPIRequest(
      path: path,
      idPathSegment: id
    )
    return request
  }
  
  func userProfileRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let request = try networkRequestService.prepareUserProfileAPIRequest(
      path: path,
      usernamePathSegment: username
    )
    return request
  }
  
  func userLikedPhotosRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareUserLikedPhotosParameters()
    let request = try networkRequestService.prepareUserLikedPhotosAPIRequest(
      path: path,
      usernamePathSegment: username,
      parameters: parameters
    )
    return request
  }
  
  func userPhotosRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareUserPhotosParameters()
    let request = try networkRequestService.prepareUserPhotosAPIRequest(
      path: path,
      usernamePathSegment: username,
      parameters: parameters
    )
    return request
  }
  
  func userAlbumsRequest(user: User) throws -> URLRequest {
    let path = userProfile.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareUserAlbumsParameters()
    let request = try networkRequestService.prepareUserAlbumsAPIRequest(
      path: path,
      usernamePathSegment: username,
      parameters: parameters
    )
    return request
  }
  
  func randomUserPhotoRequest(user: User) throws -> URLRequest {
    let path = photos.rawValue
    let username = user.username
    let parameters = PrepareParameters.prepareRandomUserPhotoParameters(
      username: username
    )
    let request = try networkRequestService.prepareRandomUserPhotoAPIRequest(
      path: path,
      parameters: parameters
    )
    return request
  }
  
  func topicPhotosRequest(topic: Topic) throws -> URLRequest {
    let topicsPath = topics.rawValue
    let id = topic.id
    let photosPath = photos.rawValue
    let parameters = PrepareParameters.preparePhotosParameters()
    let request = try networkRequestService.prepareTopicPhotosAPIRequest(
      path: topicsPath,
      idPathSegment: id,
      photosPathSegment: photosPath,
      parameters: parameters
    )
    return request
  }
  
  func albumPhotosRequest(album: Album) throws -> URLRequest {
    let albumsPath = albums.rawValue
    let id = album.id
    let photosPath = photos.rawValue
    let parameters = PrepareParameters.preparePhotosParameters()
    let request = try networkRequestService.prepareAlbumPhotosAPIRequest(
      path: albumsPath,
      idPathSegment: id,
      phtosPathSegment: photosPath,
      parameters: parameters
    )
    return request
  }
  
  func topicsTitleRequest() throws -> URLRequest {
    let topicsPath = topics.rawValue
    let request = try networkRequestService.prepareTopicsTitleAPIRequest(
      path: topicsPath
    )
    return request
  }
}
