//
//  PhotoDetailView.swift
//  Snjor
//
//  Created by Адам on 24.06.2024.
//

import UIKit
// swiftlint:disable all
class PhotoDetailView: UIView {
  // MARK: - Background Views
  let photoView: PhotoView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(PhotoView())

  let photoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      GradientView.Color(color: .clear, location: 0.35),
      GradientView.Color(color: UIColor(white: 0, alpha: 1.0), location: 0.7)
    ])
    $0.clipsToBounds = true
    return $0
  }(GradientView())

  // MARK: - Profile photo, Name, Location

  let profilePhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "profile")
    $0.layer.cornerRadius = PhotoConstants.profilePhotoCornerRadius
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(equalToConstant: PhotoConstants.profilePhotoSize).isActive = true
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.profilePhotoSize).isActive = true
    return $0
  }(UIImageView())

  let nameLabel: UILabel = {
    $0.textColor = .white
    $0.font = UIFont(name: "Times New Roman Bold", size: PhotoConstants.nameFontSize)
    return $0
  }(UILabel())

  lazy var profilePhotoAndNameStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoConstants.midlValue
    $0.addArrangedSubview(profilePhotoImageView)
    $0.addArrangedSubview(nameLabel)
    return $0
  }(UIStackView())

  // MARK: - Social
  let instagramLogoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "inst")
    $0.tintColor = .white
    $0.widthAnchor.constraint(equalToConstant: PhotoConstants.logoSize).isActive = true
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.logoSize).isActive = true
    return $0
  }(UIImageView())

  let instagramUsernameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  lazy var instStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoConstants.defaultValue
    $0.addArrangedSubview(instagramLogoImageView)
    $0.addArrangedSubview(instagramUsernameLabel)
    return $0
  }(UIStackView())

  let twitLogoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "twit")
    $0.tintColor = .white
    $0.widthAnchor.constraint(equalToConstant: PhotoConstants.logoSize).isActive = true
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.logoSize).isActive = true
    return $0
  }(UIImageView())

  let twitterUsernameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  lazy var twitStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoConstants.defaultValue
    $0.addArrangedSubview(twitLogoImageView)
    $0.addArrangedSubview(twitterUsernameLabel)
    return $0
  }(UIStackView())

  lazy var socialStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = PhotoConstants.midlValue
    $0.addArrangedSubview(instStackView)
    $0.addArrangedSubview(twitStackView)
    return $0
  }(UIStackView())

  // MARK: - First Line
  lazy var firstLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.lineHeightAnchor).isActive = true
    $0.widthAnchor.constraint(equalToConstant: frame.width - PhotoConstants.longValue).isActive = true
    return $0
  }(UIView())

  // MARK: - Likes, Downloads, Downloads button
  let heartImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "heart.fill")
    $0.tintColor = .white
    return $0
  }(UIImageView())

  let likesLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  lazy var likesStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoConstants.defaultValue
    $0.addArrangedSubview(heartImageView)
    $0.addArrangedSubview(likesLabel)
    return $0
  }(UIStackView())

  let downloadsImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "tray.and.arrow.down.fill")
    $0.tintColor = .white
    return $0
  }(UIImageView())

  let downloadsLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  lazy var downloadStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoConstants.defaultValue
    $0.addArrangedSubview(downloadsImageView)
    $0.addArrangedSubview(downloadsLabel)
    return $0
  }(UIStackView())

  lazy var profitabilityStackViews: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.spacing = PhotoConstants.longValue
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    return $0
  }(UIStackView())

  let downloadButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.layer.cornerRadius = PhotoConstants.defaultValue
    $0.setTitle(" JPEG", for: .normal)
    $0.setImage(UIImage(systemName: "arrow.down.app.fill"), for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .regular)
    $0.tintColor = .darkGray
    $0.alpha = PhotoConstants.alpha
    $0.setContentHuggingPriority(.required, for: .horizontal)
    $0.widthAnchor.constraint(equalToConstant: PhotoConstants.downloadButtonWidth).isActive = true
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.downloadButtonHeight).isActive = true
    return $0
  }(UIButton(type: .system))

  lazy var profitAndDownloadButtonStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .fill
    $0.spacing = PhotoConstants.midlValue
    $0.addArrangedSubview(profitabilityStackViews)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(downloadButton)
    return $0
  }(UIStackView())

  // MARK: - Second Line
  lazy var secondLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.lineHeightAnchor).isActive = true
    $0.widthAnchor.constraint(equalToConstant: frame.width - PhotoConstants.longValue).isActive = true
    return $0
  }(UIView())

  // MARK: - Created,
  let createdLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
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
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .black)
    return $0
  }(UILabel())

  lazy var cameraStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoConstants.defaultValue
    $0.addArrangedSubview(cameraImageView)
    $0.addArrangedSubview(cameraModelLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: - Photo size
  let resolutionLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.textAlignment = .center
    $0.backgroundColor = .darkGray
    $0.alpha = PhotoConstants.alpha
    $0.layer.cornerRadius = PhotoConstants.resolutionLabelCornerRadius
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(equalToConstant: PhotoConstants.resolutionLabelWidth).isActive = true
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.resolutionLabelHeight).isActive = true
    return $0
  }(UILabel())

  let pxLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.alpha = PhotoConstants.alpha
    return $0
  }(UILabel())

 lazy var photoResolutionStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
   $0.spacing = PhotoConstants.defaultValue
    $0.addArrangedSubview(resolutionLabel)
    $0.addArrangedSubview(pxLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: - Characteristics of photography
  let isoLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.alpha = PhotoConstants.alpha
    return $0
  }(UILabel())

  let apertureLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.alpha = PhotoConstants.alpha
    return $0
  }(UILabel())

  let focalLengthLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.alpha = PhotoConstants.alpha
    return $0
  }(UILabel())

  let exposureTimeLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.alpha = PhotoConstants.alpha
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
    $0.spacing = PhotoConstants.midlValue
    $0.addArrangedSubview(profilePhotoAndNameStackView)
    $0.addArrangedSubview(socialStackView)
    $0.addArrangedSubview(firstLine)
    $0.addArrangedSubview(profitAndDownloadButtonStackView)
    $0.addArrangedSubview(secondLine)
    $0.addArrangedSubview(createdLabel)
    $0.addArrangedSubview(cameraStackView)
    $0.addArrangedSubview(photoResolutionStackView)
    $0.addArrangedSubview(characteristicsOfPhotographyStackView)
    return $0
  }(UIStackView())

  // MARK: - Private Methods
  func setupView() {
    addSubview(photoImageView)
    addSubview(gradientView)
    addSubview(mainStackView)

    NSLayoutConstraint.activate([
      
      gradientView.topAnchor.constraint(equalTo: topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),

      photoImageView.topAnchor.constraint(equalTo: topAnchor),
      photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: PhotoConstants.photoViewBottomAnchor),
      photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PhotoConstants.mainStackLeadingAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: PhotoConstants.mainStackViewBottomAnchor),
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
