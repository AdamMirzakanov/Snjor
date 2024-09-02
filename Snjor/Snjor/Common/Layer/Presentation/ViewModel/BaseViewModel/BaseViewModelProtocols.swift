//
//  BaseViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Combine

protocol BaseViewModelProtocol {
  var state: PassthroughSubject <StateController, Never> { get }
  func viewDidLoad()
}
