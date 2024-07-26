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
    $0.font = .systemFont(ofSize: GlobalConst.defaultFontSize)
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
   func configure(with topic: Topic) {
     titleLabel.text = topic.title
   }

   // MARK: - Setup Views
   private func setupViews() {
     contentView.addSubview(titleLabel)
     titleLabel.centerXY()
   }
}
