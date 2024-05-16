//
//  Coordinatable.swift
//  Snjor
//
//  Created by Адам on 16.05.2024.
//

protocol Coordinatable: AnyObject {
  var navigation: Navigable { get set }
  func start()
}
