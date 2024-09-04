//
//  ContentManagingProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 02.09.2024.
//

protocol ContentManagingProtocol<Item>: BaseViewModelProtocol {
  associatedtype Item: ViewModelItemRepresentable, Downloadable
  var items: [Item] { get }
  func getItem(at index: Int) -> Item
  func getViewModelItem(at index: Int) -> BaseViewModelItem<Item>
  func loadItemsUseCase() async
}
