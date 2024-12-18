//
//  Parameters.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 04.09.2024.
//

typealias Parameters = [String: String]

enum ParamKey: String {
  case page
  case query
  case perPage = "per_page"
  case color = "color"
  case orientation = "orientation"
  case username = "username"
  case orderBy = "order_by"
  case width = "w"
  case devicePixelRatio = "dpr"
}

enum ParamValue: String {
  
  // orientation
  case landscape
  case portrait
  case squarish
  
  // sorting
  case latest
  
  // color filters
  case green
  case yellow
  case orange
  case red
  case purple
  case blue
  case teal
  case blackAndWhite = "black_and_white"
}
