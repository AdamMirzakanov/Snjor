//
//  PageScreenTopicCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

final class PageScreenTopicCell: UICollectionViewCell {
  // MARK: - View
  private let topicTitleLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 16, weight: .medium)
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
     topicTitleLabel.text = nil
   }

   // MARK: - Setup Data
   func configure(viewModelItem: ViewModelItem <Topic>) {
     topicTitleLabel.text = viewModelItem.itemTitle
   }

   // MARK: - Setup Views
   private func setupViews() {
     contentView.addSubview(topicTitleLabel)
     topicTitleLabel.centerXY()
   }
}
