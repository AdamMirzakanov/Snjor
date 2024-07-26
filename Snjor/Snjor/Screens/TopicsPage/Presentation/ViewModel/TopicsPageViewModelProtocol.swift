//
//  TopicsPageViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 23.07.2024.
//

protocol TopicsPageViewModelProtocol: BaseViewModelProtocol {
  var topicsCount: Int { get }
  var topics: [Topic] { get set }
}
