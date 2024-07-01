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
  let photoImageView: UIImageView = {
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

  // MARK: - Profile photo, Name
  let profilePhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: .profilePhotoDefaultImage)
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

  lazy var profilePhotoAndNameStackView: UIStackView = {
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

  // MARK: - Social
  //  let instagramLogoImageView: UIImageView = {
  //    $0.translatesAutoresizingMaskIntoConstraints = false
  //    $0.contentMode = .scaleAspectFill
  //    $0.image = UIImage(named: "inst")
  //    $0.tintColor = .white
  //    $0.widthAnchor.constraint(equalToConstant: UIConst.logoSize).isActive = true
  //    $0.heightAnchor.constraint(equalToConstant: UIConst.logoSize).isActive = true
  //    return $0
  //  }(UIImageView())
  //
  //  let instagramUsernameLabel: UILabel = {
  //    $0.text = .instagramUsernameDefault
  //    $0.textColor = .white
  //    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
  //    return $0
  //  }(UILabel())
  //
  //  lazy var instStackView: UIStackView = {
  //    $0.translatesAutoresizingMaskIntoConstraints = false
  //    $0.axis = .horizontal
  //    $0.distribution = .fill
  //    $0.alignment = .center
  //    $0.spacing = UIConst.defaultValue
  //    $0.addArrangedSubview(instagramLogoImageView)
  //    $0.addArrangedSubview(instagramUsernameLabel)
  //    return $0
  //  }(UIStackView())
  //
  //  let twitLogoImageView: UIImageView = {
  //    $0.translatesAutoresizingMaskIntoConstraints = false
  //    $0.contentMode = .scaleAspectFill
  //    $0.image = UIImage(named: "twit")
  //    $0.tintColor = .white
  //    $0.widthAnchor.constraint(equalToConstant: UIConst.logoSize).isActive = true
  //    $0.heightAnchor.constraint(equalToConstant: UIConst.logoSize).isActive = true
  //    return $0
  //  }(UIImageView())
  //
  //  let twitterUsernameLabel: UILabel = {
  //    $0.text = .twitterUsernameDefault
  //    $0.textColor = .white
  //    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .medium)
  //    return $0
  //  }(UILabel())
  //
  //  lazy var twitStackView: UIStackView = {
  //    $0.translatesAutoresizingMaskIntoConstraints = false
  //    $0.axis = .horizontal
  //    $0.distribution = .fill
  //    $0.alignment = .center
  //    $0.spacing = UIConst.defaultValue
  //    $0.addArrangedSubview(twitLogoImageView)
  //    $0.addArrangedSubview(twitterUsernameLabel)
  //    return $0
  //  }(UIStackView())
  //
  //  lazy var socialStackView: UIStackView = {
  //    $0.translatesAutoresizingMaskIntoConstraints = false
  //    $0.axis = .vertical
  //    $0.spacing = UIConst.midlValue
  //    $0.addArrangedSubview(instStackView)
  //    $0.addArrangedSubview(twitStackView)
  //    return $0
  //  }(UIStackView())

  // MARK: - First Line
  lazy var firstLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = UIConst.alpha
    $0.heightAnchor.constraint(equalToConstant: UIConst.lineHeightAnchor).isActive = true
    return $0
  }(UIView())

  // MARK: - Likes, Downloads, Downloads button
  let heartImageView: UIImageView = {
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

  let downloadsImageView: UIImageView = {
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

  lazy var downloadStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(downloadsImageView)
    $0.addArrangedSubview(downloadsLabel)
    return $0
  }(UIStackView())

  let viewsImageView: UIImageView = {
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

  lazy var viewsStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = UIConst.defaultValue
    $0.addArrangedSubview(viewsImageView)
    $0.addArrangedSubview(viewsLabel)
    return $0
  }(UIStackView())

  lazy var profitabilityStackViews: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.spacing = UIConst.longValue
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    $0.addArrangedSubview(viewsStackView)
    return $0
  }(UIStackView())

  let infoButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setImage(UIImage(systemName: "info.circle"), for: .normal)
    $0.tintColor = .white
    $0.alpha = UIConst.alpha
    return $0
  }(UIButton(type: .system))

  lazy var profitAndDownloadButtonStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .fill
    $0.spacing = UIConst.midlValue
    $0.addArrangedSubview(profitabilityStackViews)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: - Second Line
  lazy var secondLine: UIView = {
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
  let cameraImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "camera.aperture")
    $0.tintColor = .white
    return $0
  }(UIImageView())

  var cameraModelLabel: UILabel = {
    $0.text = .cameraDefault
    $0.textColor = .white
    $0.font = .systemFont(ofSize: UIConst.defaultFontSize, weight: .black)
    return $0
  }(UILabel())

  lazy var cameraStackView: UIStackView = {
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

  lazy var photoResolutionStackView: UIStackView = {
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

  // MARK: - Characteristics of photography
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

  lazy var characteristicsOfPhotographyStackView: UIStackView = {
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

  // MARK: - Сontaining everything
  lazy var mainStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = UIConst.midlValue
    //    $0.backgroundColor = .brown
//    $0.addArrangedSubview(profilePhotoAndNameStackView)
    $0.addArrangedSubview(firstLine)
    $0.addArrangedSubview(profitAndDownloadButtonStackView)
    $0.addArrangedSubview(secondLine)
    $0.addArrangedSubview(createdLabel)
    $0.addArrangedSubview(cameraStackView)
    $0.addArrangedSubview(photoResolutionStackView)
    $0.addArrangedSubview(characteristicsOfPhotographyStackView)
    return $0
  }(UIStackView())

  lazy var overlordStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = UIConst.midlValue
    //    $0.backgroundColor = .brown
    $0.addArrangedSubview(profilePhotoAndNameStackView)
    $0.addArrangedSubview(mainStackView)
    return $0
  }(UIStackView())

  // MARK: - Private Methods
  func setupView() {
    addSubview(photoImageView)
    addSubview(gradientView)
    addSubview(overlordStackView)
    NSLayoutConstraint.activate([

      gradientView.topAnchor.constraint(equalTo: topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),

      photoImageView.topAnchor.constraint(equalTo: topAnchor),
      photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

      overlordStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConst.mainStackLeadingAnchor),
      overlordStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConst.mainStackLeadingAnchor),
      overlordStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
    ])
  }

  // MARK: - Public Methods
  func createdAt(from date: String) {
    guard let date = ISO8601DateFormatter().date(from: date) else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    let readableDate = dateFormatter.string(from: date)
    createdLabel.text = readableDate
  }
}


