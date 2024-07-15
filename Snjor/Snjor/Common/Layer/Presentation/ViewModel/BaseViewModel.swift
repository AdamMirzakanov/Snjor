//
//  BaseViewModel.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

import Combine

protocol BaseViewModelProtocol {
  var state: PassthroughSubject<StateController, Never> { get }
  func viewDidLoad()
}
