//
//  UserProfileCollectionView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 12.09.2024.
//

import UIKit

final class UserProfileCollectionView: MainCollectionView {
  private let layoutFactory = UserProfileLayoutFactory()
  
  override func cellRegister() {
    register(
      FirstCell.self,
      forCellWithReuseIdentifier: FirstCell.reuseID
    )
    register(
      SecondCell.self,
      forCellWithReuseIdentifier: SecondCell.reuseID
    )
    register(
      ThirdCell.self,
      forCellWithReuseIdentifier: ThirdCell.reuseID
    )
    
    register(
      HeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: HeaderView.reuseID
    )
  }
  
  override func configureLayout() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let screenWidth = UIScreen.main.bounds.width
    layout.itemSize = CGSize(
      width: screenWidth,
      height: UserProfileViewControllerRootViewConst.heightUserProfileCollectionView
    )
    layout.sectionInset = .zero
    layout.minimumLineSpacing = .zero
    layout.minimumInteritemSpacing = .zero
    decelerationRate = .fast
    isPagingEnabled = true
    collectionViewLayout = layout
    
    //    collectionViewLayout = layoutFactory.createUserProfileCollecitonViewLayout()
  }
}

class HeaderView: UICollectionReusableView, Reusable {
  
  private let titleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    
  }
  
  private func setupView() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  func setTitle(_ text: String) {
    titleLabel.text = text
  }
}
