//
//  Authorization.swift
//  Snjor
//
//  Created by Адам on 15.06.2024.
//

/// Перечисление содержащее статическое свойство для получения ключа доступа к API.
enum Authorization {
  
  /// Свойство, возвращающее случайный ключ доступа из предопределенного списка.
  /// Используется для авторизации запросов к API.
  /// Случайный выбор ключа позволяет обходить лимит на количество запросов, установленных API.
  /// Если список пустой или ключи недоступны, возвращается пустая строка.
  static var accessKey: String {
    let keys = [
      "qWxk9iN9WGD2gnCZnQuvC34hNqUDWGPr5bV_dLRC89s",
      "rcKlvKOv4ZNiLed47VZnync8ynWaNDNYw0MxZ5Tqiko",
      "gPoLLPuPfcL6D6GBbc48sOyLuLD9z2CFbdVNaZ8juFE",
      "Ce9XSW39p8HVwa98GInAYBURSalesGqzX1ZAjfQPdio",
      "gLMW-rd9s9p_Rg5dNG9C4rHQec6v1M9XHao5awwxFno",
      "r6w7Z9ZngliQ2zpcveM-wtWeAKF_urQWYP1evbOu6ys",
      "cPT2fqhm-IU6GJYAvkSoChMFKd6cB1R9J9fho71HbK4",
      "J_rWahdyRoNQS2PxNatW5yF2-65ynb5zXQU1sRblerE"
    ]
    return keys.randomElement() ?? .empty
  }
}
