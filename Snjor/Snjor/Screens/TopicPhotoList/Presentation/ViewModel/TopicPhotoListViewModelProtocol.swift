//
//  TopicPhotoListViewModelProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 28.07.2024.
//

import UIKit

protocol TopicPhotoListViewModelProtocol: BaseViewModelProtocol {
  var photosCount: Int { get }
  var snapshot: NSDiffableDataSourceSnapshot<Section, Photo> { get }
  func getTopicPhotoListViewModelItem(at index: Int) -> TopicPhotoListViewModelItem
  func getPhoto(at index: Int) -> Photo
}
