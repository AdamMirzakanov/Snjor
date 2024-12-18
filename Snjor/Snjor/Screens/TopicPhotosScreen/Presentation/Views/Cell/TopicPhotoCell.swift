//
//  TopicPhotoCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 17.08.2024.
//

import UIKit

final class TopicPhotoCell: MainPhotoCell {
  // MARK: Delegate
  weak var delegate: (any TopicPhotoCellDelegate)?
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    mainView.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError(ErrorMessage.initCoderNotImplementedError)
  }
}
