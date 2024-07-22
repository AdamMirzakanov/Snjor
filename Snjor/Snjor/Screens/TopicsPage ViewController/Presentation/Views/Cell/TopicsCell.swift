//
//  TopicsCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

final class TopicsCell: UICollectionViewCell {
  // MARK: - View
  let titleLabel: UILabel = {
    $0.textColor = .label
    return $0
  }(UILabel())
  
  // MARK: - Initializers
   override init(frame: CGRect) {
     super.init(frame: frame)
     setupViews()
   }

   required init?(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
   }

   // MARK: - Override Methods
   override func prepareForReuse() {
     super.prepareForReuse()
   }

   // MARK: - Setup Data
   func configure(with topicPhoto: Topic) {
     titleLabel.text = topicPhoto.title
   }

   // MARK: - Setup Views
   private func setupViews() {
     contentView.addSubview(titleLabel)
     titleLabel.centerXY()
   }
}
