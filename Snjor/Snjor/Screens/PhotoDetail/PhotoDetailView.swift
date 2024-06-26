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
  private let photoView: PhotoView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(PhotoView())

  private let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      GradientView.Color(color: .clear, location: 0.35),
      GradientView.Color(color: UIColor(white: 0, alpha: 1.0), location: 0.7)
    ])
    $0.clipsToBounds = true
    return $0
  }(GradientView())

  // MARK: - Profile photo, Name, Location
  private let profilePhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "profile")
    $0.layer.cornerRadius = PhotoConstants.profilePhotoCornerRadius
    $0.clipsToBounds = true
    $0.widthAnchor.constraint(equalToConstant: PhotoConstants.profilePhotoSize).isActive = true
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.profilePhotoSize).isActive = true
    return $0
  }(UIImageView())

  private let nameLabel: UILabel = {
    $0.textColor = .white
    $0.font = UIFont(name: "Times New Roman Bold", size: PhotoConstants.nameFontSize)
    return $0
  }(UILabel())

  private lazy var profilePhotoAndNameStackView: UIStackView = {
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
  private let instagramLogoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "inst")
    $0.tintColor = .white
    $0.widthAnchor.constraint(equalToConstant: PhotoConstants.logoSize).isActive = true
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.logoSize).isActive = true
    return $0
  }(UIImageView())

  private let instagramUsernameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  private lazy var instStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoConstants.defaultValue
    $0.addArrangedSubview(instagramLogoImageView)
    $0.addArrangedSubview(instagramUsernameLabel)
    return $0
  }(UIStackView())

  private let twitLogoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "twit")
    $0.tintColor = .white
    $0.widthAnchor.constraint(equalToConstant: PhotoConstants.logoSize).isActive = true
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.logoSize).isActive = true
    return $0
  }(UIImageView())

  private let twitterUsernameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  private lazy var twitStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoConstants.defaultValue
    $0.addArrangedSubview(twitLogoImageView)
    $0.addArrangedSubview(twitterUsernameLabel)
    return $0
  }(UIStackView())

  private lazy var socialStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = PhotoConstants.midlValue
    $0.addArrangedSubview(instStackView)
    $0.addArrangedSubview(twitStackView)
    return $0
  }(UIStackView())

  // MARK: - First Line
  private lazy var firstLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.lineHeightAnchor).isActive = true
    $0.widthAnchor.constraint(equalToConstant: frame.width - PhotoConstants.longValue).isActive = true
    return $0
  }(UIView())

  // MARK: - Likes, Downloads, Downloads button
  private let heartImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "heart.fill")
    $0.tintColor = .white
    return $0
  }(UIImageView())

  private let likesLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  private lazy var likesStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoConstants.defaultValue
    $0.addArrangedSubview(heartImageView)
    $0.addArrangedSubview(likesLabel)
    return $0
  }(UIStackView())

  private let downloadsImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "tray.and.arrow.down.fill")
    $0.tintColor = .white
    return $0
  }(UIImageView())

  private let downloadsLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  private lazy var downloadStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = PhotoConstants.defaultValue
    $0.addArrangedSubview(downloadsImageView)
    $0.addArrangedSubview(downloadsLabel)
    return $0
  }(UIStackView())

  private lazy var profitabilityStackViews: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.spacing = PhotoConstants.longValue
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    return $0
  }(UIStackView())

  private let downloadButton: UIButton = {
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

  private lazy var profitAndDownloadButtonStackView: UIStackView = {
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
  private lazy var secondLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.heightAnchor.constraint(equalToConstant: PhotoConstants.lineHeightAnchor).isActive = true
    $0.widthAnchor.constraint(equalToConstant: frame.width - PhotoConstants.longValue).isActive = true
    return $0
  }(UIView())

  // MARK: - Created,
  private let createdLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    return $0
  }(UILabel())

  // MARK: - Camera model
  private let cameraImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "camera.aperture")
    $0.tintColor = .white
    return $0
  }(UIImageView())

  private var cameraModelLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .black)
    return $0
  }(UILabel())

  private lazy var cameraStackView: UIStackView = {
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
  private let resolutionLabel: UILabel = {
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

  private let pxLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.alpha = PhotoConstants.alpha
    return $0
  }(UILabel())

 private lazy var photoResolutionStackView: UIStackView = {
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
  private let isoLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.alpha = PhotoConstants.alpha
    return $0
  }(UILabel())

  private let apertureLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.alpha = PhotoConstants.alpha
    return $0
  }(UILabel())

  private let focalLengthLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.alpha = PhotoConstants.alpha
    return $0
  }(UILabel())

  private let exposureTimeLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: PhotoConstants.defaultFontSize, weight: .medium)
    $0.alpha = PhotoConstants.alpha
    return $0
  }(UILabel())

  private lazy var characteristicsOfPhotographyStackView: UIStackView = {
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
  private lazy var mainStackView: UIStackView = {
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
    addSubview(photoView)
    addSubview(gradientView)
    addSubview(mainStackView)

    NSLayoutConstraint.activate([
      
      gradientView.topAnchor.constraint(equalTo: topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),

      photoView.topAnchor.constraint(equalTo: topAnchor),
      photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: PhotoConstants.photoViewBottomAnchor),
      photoView.leadingAnchor.constraint(equalTo: leadingAnchor),
      photoView.trailingAnchor.constraint(equalTo: trailingAnchor),

      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PhotoConstants.mainStackLeadingAnchor),
      mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: PhotoConstants.mainStackViewBottomAnchor),
    ])

  }
  // MARK: - Public Methods
  func updateUI(with photo: Photo) {
    photoView.setupImageView()
    photoView.configure(with: photo)
    nameLabel.text = photo.user.displayName
    likesLabel.text = String(photo.likes)
    downloadsLabel.text = String(photo.downloads ?? Int.zero)
    createdAt(from: photo.createdAt)
    guard let exif = photo.exif else { return }
    cameraModelLabel.text = exif.model ?? DefaultTextForLabel.cameraModel
    resolutionLabel.text = determineResolutionCategory(width: photo.width, height: photo.height)
    pxLabel.text = "\(photo.width) × \(photo.height)"
    isoLabel.text = "ISO \(exif.iso ?? Int.zero)" + DefaultTextForLabel.dot
    focalLengthLabel.text = "\(exif.focalLength ?? "0") mm" + DefaultTextForLabel.dot
    apertureLabel.text = "𝑓 \(exif.aperture ?? "0.0")" + DefaultTextForLabel.dot
    exposureTimeLabel.text = "\(exif.exposureTime ?? "0/0") s"
    guard let social = photo.user.social else { return }
    instagramUsernameLabel.text = social.instagramUsername ?? photo.user.username
    twitterUsernameLabel.text = social.twitterUsername ?? photo.user.username 
  }

  // MARK: - Private Methods
  private func createdAt(from date: String) {
    guard let date = ISO8601DateFormatter().date(from: date) else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    let readableDate = dateFormatter.string(from: date)
    createdLabel.text = readableDate
  }

  func determineResolutionCategory(width: Int, height: Int) -> String {
    let maxDimension = max(width, height)
    switch maxDimension {
    case 7680...:
      return Resolution.uhd8K
    case 3840..<7680:
      return Resolution.uhd4K
    case 2560..<3840:
      return Resolution.qhd2K
    case 1920..<2560:
      return Resolution.fullHD
    case 1280..<1920:
      return Resolution.hd
    default:
      return Resolution.standard
    }
  }
}
