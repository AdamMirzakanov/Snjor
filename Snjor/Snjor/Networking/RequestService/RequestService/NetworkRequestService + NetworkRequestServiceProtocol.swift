//
//  NetworkRequestService + NetworkRequestServiceProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

import Foundation

fileprivate typealias Const = PrepareRequestConst

extension NetworkRequestService: NetworkRequestServiceProtocol {
  func prepareTopicsTitleAPIRequest(
    path: String
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path) else {
      throw APIError.URLError
    }
    let request = prepareURLRequest(url: url)
    return request
  }

  func prepareTopicPhotosAPIRequest(
    path: String,
    idPathSegment: String,
    photosPathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let topicsIdURL = url.appending(path: idPathSegment)
    let topicsPhotosURL = topicsIdURL.appending(path: photosPathSegment)
    let request = prepareURLRequest(url: topicsPhotosURL)
    return request
  }

  func prepareAlbumPhotosAPIRequest(
    path: String,
    idPathSegment: String,
    phtosPathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let albumIdURL = url.appending(path: idPathSegment)
    let albumPhotosURL = albumIdURL.appending(path: phtosPathSegment)
    let request = prepareURLRequest(url: albumPhotosURL)
    return request
  }

  func preparePhotoInfoAPIRequest(
    path: String,
    idPathSegment: String
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path) else {
      throw APIError.URLError
    }
    let photoInfoURL = url.appending(component: idPathSegment)
    let request = prepareURLRequest(url: photoInfoURL)
    return request
  }

  func prepareUserProfileAPIRequest(
    path: String,
    usernamePathSegment: String
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path) else {
      throw APIError.URLError
    }
    let profileURL = url.appending(component: usernamePathSegment)
    let request = prepareURLRequest(url: profileURL)
    return request
  }

  func prepareUserLikedPhotosAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let profileURL = url.appending(component: usernamePathSegment)
    let likedURL = profileURL.appending(component: Const.likesPathComponent)
    let request = prepareURLRequest(url: likedURL)
    return request
  }

  func prepareRandomUserPhotoAPIRequest(
    path: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let randomURL = url.appending(component: Const.randomPathComponent)
    let request = prepareURLRequest(url: randomURL)
    return request
  }

  func prepareUserPhotosAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let profileURL = url.appending(component: usernamePathSegment)
    let photosURL = profileURL.appending(component: Const.photosPathComponent)
    let request = prepareURLRequest(url: photosURL)
    return request
  }

  func prepareUserAlbumsAPIRequest(
    path: String,
    usernamePathSegment: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let profileURL = url.appending(component: usernamePathSegment)
    let collectionsURL = profileURL.appending(component: Const.collectionsPathComponent)
    let request = prepareURLRequest(url: collectionsURL)
    return request
  }

  func prepareAPIRequest(
    path: String,
    parameters: Parameters
  ) throws -> URLRequest {
    guard let url = prepareURL(from: path, parameters: parameters) else {
      throw APIError.URLError
    }
    let request = prepareURLRequest(url: url)
    return request
  }
}
