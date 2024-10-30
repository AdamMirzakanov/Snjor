//
//  BaseViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

import Combine

/// Протокол `BaseViewModelProtocol` определяет основные
/// свойства и методы для базовых `ViewModel`.
///
/// Протокол включает состояние и метод, вызываемый при загрузке представления.
protocol BaseViewModelProtocol {
  // MARK: - Internal Properties
  /// Свойство, представляющее состояние ViewModel через `PassthroughSubject`.
  var state: PassthroughSubject<StateController, Never> { get }
  
  // MARK: - Internal Methods
  /// Метод, вызываемый при загрузке представления (например, для инициализации данных).
  func viewDidLoad()
}

