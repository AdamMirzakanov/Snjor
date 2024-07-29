//
//  TopicsPageViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

protocol TopicsPageViewModelProtocol: BaseViewModelProtocol {
  var topicsCount: Int { get }
  func getTopicsPageViewModelItem(at index: Int) -> TopicsPageViewModelItem
}
