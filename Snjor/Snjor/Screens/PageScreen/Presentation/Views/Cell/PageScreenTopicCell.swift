//
//  PageScreenTopicCell.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 22.07.2024.
//

import UIKit

fileprivate typealias Const = PageScreenTopicCellConst

final class PageScreenTopicCell: UICollectionViewCell {
  // MARK: Views
  private let topicTitleLabel: UILabel = {
    $0.textColor = .white
    $0.textAlignment = .center
    $0.font = .systemFont(
      ofSize: Const.topicTitleLabelFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())
  
  // MARK: Initializers
   override init(frame: CGRect) {
     super.init(frame: frame)
     setupViews()
   }

   required init?(coder: NSCoder) {
     fatalError(.requiredInitFatalErrorText)
   }

   // MARK: Override Methods
   override func prepareForReuse() {
     super.prepareForReuse()
     topicTitleLabel.text = nil
   }

   // MARK: Setup Data
   func configure(viewModelItem: BaseViewModelItem <Topic>) {
     topicTitleLabel.text = viewModelItem.itemTitle
   }

   // MARK: Setup Views
   private func setupViews() {
     contentView.addSubview(topicTitleLabel)
     topicTitleLabel.centerXY()
   }
}
