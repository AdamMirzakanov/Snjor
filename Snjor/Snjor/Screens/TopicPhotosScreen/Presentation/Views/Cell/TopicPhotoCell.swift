//
//  TopicPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

final class TopicPhotoCell: MainPhotoCell {
  weak var delegate: (any TopicPhotoCellDelegate)?
  
  override func setupDelegate() {
    rootView.mainView.delegate = self
  }
}
