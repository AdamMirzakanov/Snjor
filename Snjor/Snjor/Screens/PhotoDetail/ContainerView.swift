//
//  ContainerView.swift
//  Snjor
//
//  Created by Адам on 24.06.2024.
//

import UIKit
// swiftlint:disable all
class ContainerView: UIView {
  // MARK: - Background Views
  let mainPhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    let color = UIColor(white: .zero, alpha: UIConst.gradientAlpha)
    $0.setColors([
      GradientView.Color(
        color: .clear,
        location: UIConst.halfLocation
      ),
      GradientView.Color(
        color: color,
        location: UIConst.location
      )
    ])
    $0.clipsToBounds = true
    return $0
  }(GradientView())

  // MARK: - Profile
  let profilePhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: .profileDefaultPhotoImage)
    $0.layer.cornerRadius = UIConst.backButtonBlurViewCornerRadius
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(equalToConstant: UIConst.blurViewSize).isActive = true
    $0.heightAnchor.constraint(equalToConstant: UIConst.blurViewSize).isActive = true
    return $0
  }(UIImageView())

  let nameLabel: UILabel = {
    $0.text = .nameDefault
    $0.textColor = .white
    $0.font = UIFont(name: .nameFont, size: UIConst.nameFontSize)
    return $0
  }(UILabel())

  let infoButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setImage(UIImage(systemName: "info.circle"), for: .normal)
    $0.tintColor = .white
    $0.alpha = UIConst.alpha
    return $0
  }(UIButton(type: .system))

  // MARK: - Profile StackView
 lazy var profileStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.midlValue
    $0.addArrangedSubview(profilePhotoImageView)
    $0.addArrangedSubview(nameLabel)
    $0.addArrangedSubview(infoButton)
    return $0
  }(UIStackView())

  // MARK: - First Line
  private let firstLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = UIConst.alpha
    $0.heightAnchor.constraint(equalToConstant: UIConst.lineHeightAnchor).isActive = true
    return $0
  }(UIView())

  // MARK: - Likes
  private let heartImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .heartImage)
    $0.tintColor = .systemBrown
    return $0
  }(UIImageView())

  let likesLabel: UILabel = {
    $0.text = .likesDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  lazy var likesStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(heartImageView)
    $0.addArrangedSubview(likesLabel)
    return $0
  }(UIStackView())

  // MARK: - Downloads
  private let downloadsImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .downloadsImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())

  let downloadsLabel: UILabel = {
    $0.text = .downloadDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  private lazy var downloadStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(downloadsImageView)
    $0.addArrangedSubview(downloadsLabel)
    return $0
  }(UIStackView())

  // MARK: - Views
  private let viewsImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .viewsImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())

  let viewsLabel: UILabel = {
    $0.text = .viewsDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  private lazy var viewsStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(viewsImageView)
    $0.addArrangedSubview(viewsLabel)
    return $0
  }(UIStackView())

  // MARK: - Profit StackViews
  private lazy var profitStackViews: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.spacing = UIConst.longValue
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    $0.addArrangedSubview(viewsStackView)
    return $0
  }(UIStackView())

  private lazy var profitAndInfoButtonStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .fill
    $0.spacing = UIConst.midlValue
    $0.addArrangedSubview(profitStackViews)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: - Second Line
  private let secondLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = UIConst.alpha
    $0.heightAnchor.constraint(equalToConstant: UIConst.lineHeightAnchor).isActive = true
    return $0
  }(UIView())

  // MARK: - Created,
  let createdLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  // MARK: - Camera model
  private let cameraImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: .cameraImage)
    $0.tintColor = .white
    return $0
  }(UIImageView())

  var cameraModelLabel: UILabel = {
    $0.text = .cameraDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .black)
    return $0
  }(UILabel())

  private lazy var cameraStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(cameraImageView)
    $0.addArrangedSubview(cameraModelLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: - Photo size
  let resolutionLabel: UILabel = {
    $0.text = .resolutionDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.textAlignment = .center
    $0.backgroundColor = .darkGray
    $0.alpha = UIConst.alpha
    $0.layer.cornerRadius = UIConst.resolutionLabelCornerRadius
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(equalToConstant: UIConst.resolutionLabelWidth).isActive = true
    $0.heightAnchor.constraint(equalToConstant: UIConst.resolutionLabelHeight).isActive = true
    return $0
  }(UILabel())

  let pxLabel: UILabel = {
    $0.text = .pxlDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alpha
    return $0
  }(UILabel())

  private lazy var photoResolutionStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(resolutionLabel)
    $0.addArrangedSubview(pxLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: - Characteristics photo
  let isoLabel: UILabel = {
    $0.text = .isoDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alpha
    return $0
  }(UILabel())

  let apertureLabel: UILabel = {
    $0.text = .apertureDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alpha
    return $0
  }(UILabel())

  let focalLengthLabel: UILabel = {
    $0.text = .focalLengtDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alpha
    return $0
  }(UILabel())

  let exposureTimeLabel: UILabel = {
    $0.text = .exposureDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
    $0.alpha = UIConst.alpha
    return $0
  }(UILabel())

  private lazy var characteristicsPhotoStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.addArrangedSubview(isoLabel)
    $0.addArrangedSubview(focalLengthLabel)
    $0.addArrangedSubview(apertureLabel)
    $0.addArrangedSubview(exposureTimeLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: - Photo Info StackView
  lazy var photoInfoStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = UIConst.midlValue
    $0.addArrangedSubview(firstLine)
    $0.addArrangedSubview(profitAndInfoButtonStackView)
    $0.addArrangedSubview(secondLine)
    $0.addArrangedSubview(createdLabel)
    $0.addArrangedSubview(cameraStackView)
    $0.addArrangedSubview(photoResolutionStackView)
    $0.addArrangedSubview(characteristicsPhotoStackView)
    return $0
  }(UIStackView())

  // MARK: - Main StackView
  lazy var mainStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = UIConst.midlValue
    $0.addArrangedSubview(profileStackView)
    $0.addArrangedSubview(photoInfoStackView)
    return $0
  }(UIStackView())

  // MARK: - Public Methods
  func createdAt(from date: String) {
    guard let date = ISO8601DateFormatter().date(from: date) else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    let readableDate = dateFormatter.string(from: date)
    createdLabel.text = readableDate
  }

  // MARK: - Private Methods
  func setupView() {
    addSubview(mainPhotoImageView)
    addSubview(gradientView)
    addSubview(mainStackView)
    
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),

      mainPhotoImageView.topAnchor.constraint(equalTo: topAnchor),
      mainPhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      mainPhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      mainPhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConst.mainStackLeadingAnchor),
      mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConst.mainStackLeadingAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
    ])
  }
}


