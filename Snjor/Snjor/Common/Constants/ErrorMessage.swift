//
//  ErrorMessage.swift
//  Snjor
//
//  Created by Адам on 16.06.2024.
//

enum ErrorMessage {
  /// Сообщение об ошибке, если не реализован инициализатор init(coder:).
  static var initCoderNotImplementedError: String {
    "init(coder:) has not been implemented"
  }
  
  /// Сообщение об ошибке, если подкласс не переопределил метод для регистрации ячеек.
  static var mustOverrideCellRegister: String {
    "Subclasses must override cellRegister() to register cells."
  }
  
  // MARK: ViewLoadable
  /// Сообщение об ошибке, если ожидаемый тип представления не совпадает с фактическим типом.
  static var errorTemplate: String {
    "Expected view to be of type %@ but got %@ instead"
  }
  
}
