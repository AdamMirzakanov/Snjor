//
//  Location.swift
//  Snjor
//
//  Created by Адам on 30.06.2024.
//

// MARK: - Location
struct Location: Decodable, Hashable {
  let city: String?
  let country: String?
  let position: Position?
}

// MARK: - Position
struct Position: Decodable, Hashable {
  let latitude: Double?
  let longitude: Double?
}
