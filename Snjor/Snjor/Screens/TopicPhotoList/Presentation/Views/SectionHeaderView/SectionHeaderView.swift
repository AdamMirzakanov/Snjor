//
//  SectionHeaderView.swift
//  Snjor
//
//  Created by Адам on 20.07.2024.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {

  // MARK: - Photo View
  let photoImageView: UIImageView = {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.backgroundColor = .systemPurple
    $0.image = UIImage(named: "hedarMockPhoto")
    return $0
  }(UIImageView())

  // MARK: - Gradient
  let gradientView: GradientView = {
    let color = UIColor(
      white: .zero,
      alpha: SectionHeaderViewConst.gradientAlpha
    )
    $0.setColors([
      GradientView.Color(
        color: .clear,
        location: SectionHeaderViewConst.downLocation
      ),
      GradientView.Color(
        color: color,
        location: SectionHeaderViewConst.gradientAlpha
      )
    ])
    return $0
  }(GradientView())

  // MARK: - Labels
  let photosForEveryoneLabel: UILabel = {
    $0.text = .photosForEveryone
    $0.textColor = .label
    $0.font = .systemFont(
      ofSize: SectionHeaderViewConst.photosForEveryoneLabelFontSize,
      weight: .bold
    )
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowRadius = SectionHeaderViewConst.shadowRadius
    $0.layer.shadowOpacity = SectionHeaderViewConst.shadowOpacity
    $0.layer.shadowOffset = CGSize(
      width: Int.zero,
      height: Int.zero
    )
    $0.layer.masksToBounds = false
    return $0
  }(UILabel())

  let photoOfTheDay: UILabel = {
    $0.text = .photoOfTheDay
    $0.textColor = .white
    $0.font = .systemFont(
      ofSize: SectionHeaderViewConst.photoOfTheDayFontSize,
      weight: .medium
    )
    return $0
  }(UILabel())

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }

  private func addSubviews() {
    addSubview(photoImageView)
    photoImageView.addSubview(gradientView)
    photoImageView.addSubview(photosForEveryoneLabel)
//    photoImageView.addSubview(photoOfTheDay)
  }

  private func setupConstraints() {
    photoImageView.fillSuperView()
//    gradientView.fillSuperView()
    photosForEveryoneLabel.centerXY()
//    photoOfTheDay.centerX()
//    photoOfTheDay.setConstraints(
//      bottom: bottomAnchor,
//      pBottom: SectionHeaderViewConst.bottomPadding
//    )
  }

  func setImage() {
//    photoImageView.image = UIImage(named: "day")!
  }
}
