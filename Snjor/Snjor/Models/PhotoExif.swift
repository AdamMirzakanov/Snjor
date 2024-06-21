//
//  PhotoExif.swift
//  Snjor
//
//  Created by Адам on 21.06.2024.
//

struct PhotoExif: Decodable, Hashable {
  let aperture: String
  let exposureTime: String
  let focalLength: String
  let iso: String
  let make: String
  let model: String
}
