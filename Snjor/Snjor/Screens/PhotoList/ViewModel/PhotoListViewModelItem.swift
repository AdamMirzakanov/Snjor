//
//  PhotoListViewModelItem.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

struct PhotoListViewModelItem {
  var name: String {
    photo.user.displayName
  }

  var imageData: Data? {
    dataImageUseCase.getDataFromCache(url: photo.urls[.regular])
  }

  var profileImageData: Data? {
    dataImageUseCase.getDataFromCache(url: photo.urls[.regular])
  }

  private(set) var photo: Photo
  private(set) var dataImageUseCase: any ImageDataUseCaseProtocol

  func getImageData() async -> Data? {
    let url = photo.urls[.regular]
    let id = photo.id
    let data = await dataImageUseCase.getData(url: url)
    return data
  }
}
