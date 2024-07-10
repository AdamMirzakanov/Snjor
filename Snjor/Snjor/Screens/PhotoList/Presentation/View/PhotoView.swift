//
//  PhotoView.swift
//  Snjor
//
//  Created by Адам on 08.07.2024.
//

import UIKit

class PhotoView: BasePhotoView {
  override func sizedImageURL(from url: URL) -> URL {
    layoutIfNeeded()
    print(#function)
    return url.appending(queryItems: [
      URLQueryItem(name: "w", value: "\(frame.width)"),
      URLQueryItem(name: "dpr", value: "\(Int(screenScale))")
    ])
  }
}
