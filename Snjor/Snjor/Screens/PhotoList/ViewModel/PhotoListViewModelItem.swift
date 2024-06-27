//
//  PhotoListViewModelItem.swift
//  Snjor
//
//  Created by Адам on 26.06.2024.
//

import Foundation

struct PhotoListViewModelItem {
  var name: String { photo.user.displayName }
  var imageDataFromCache: Data? {
    let url = photo.urls[.thumb]
    return dataImageUseCase.getDataFromCache(url: url)
  }

  private(set) var photo: Photo
  private(set) var dataImageUseCase: any ImageDataUseCaseProtocol

  func getImageData() async -> Data? {
    let url = photo.urls[.thumb]
    let data = await dataImageUseCase.getData(url: url)
    return data
  }
}
