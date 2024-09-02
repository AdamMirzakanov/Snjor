//
//  ViewModelItemRepresentable.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Foundation

protocol ViewModelItemRepresentable {
  var regularURL: URL? { get }
  var id: String { get }
  var title: String { get }
}
