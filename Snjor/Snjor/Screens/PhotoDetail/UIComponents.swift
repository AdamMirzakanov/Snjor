//
//  UIComponents.swift
//  Snjor
//
//  Created by Адам on 24.06.2024.
//

import UIKit

enum UIComponents {
  // MARK: - Background Photo
  static let backgroundPhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    return $0
  }(UIImageView())

  static let gradientView: GradientView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.setColors([
      GradientView.Color(color: .clear, location: 0.35),
      GradientView.Color(
        color: UIColor(
          white: 0,
          alpha: 1.0
        ),
        location: 0.7
      )
    ])
    return $0
  }(GradientView())

//  func photoView() -> PhotoViewRegularQuality {
//    let view = PhotoViewRegularQuality()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//  }

  static let photoView: PhotoViewRegularQuality = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(PhotoViewRegularQuality())

  // MARK: - Profile photo, Name, Location
  static let profilePhotoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "profile")
    $0.layer.cornerRadius = 27
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  static var nameLabel: UILabel = {
    $0.textColor = .white
    $0.font = UIFont(name: "Times New Roman Bold", size: 25)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  static let pinImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "mappin")
    $0.tintColor = .white
    $0.alpha = 0.9
    return $0
  }(UIImageView())

  static var locationLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 14, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  static var locationStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 4
    $0.addArrangedSubview(pinImageView)
    $0.addArrangedSubview(locationLabel)
    return $0
  }(UIStackView())

  static var nameAndLocationStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .leading
    $0.spacing = 8
    $0.addArrangedSubview(nameLabel)
    $0.addArrangedSubview(locationStackView)
    return $0
  }(UIStackView())

  static var profilePhotoNameLocationStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 16
    $0.addArrangedSubview(profilePhotoImageView)
    $0.addArrangedSubview(nameAndLocationStackView)
    return $0
  }(UIStackView())

  // MARK: - Social
  static let instLogoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "inst")
    $0.tintColor = .white
    $0.alpha = 0.9
    $0.widthAnchor.constraint(equalToConstant: 17).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 17).isActive = true
    return $0
  }(UIImageView())

  static var instUsernameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  static var instStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 10
    $0.addArrangedSubview(instLogoImageView)
    $0.addArrangedSubview(instUsernameLabel)
    return $0
  }(UIStackView())

  static let twitLogoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "twit")
    $0.tintColor = .white
    $0.alpha = 0.9
    $0.widthAnchor.constraint(equalToConstant: 16).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 16).isActive = true
    return $0
  }(UIImageView())

  static var twitUsernameLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  static var twitStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 10
    $0.addArrangedSubview(twitLogoImageView)
    $0.addArrangedSubview(twitUsernameLabel)
    return $0
  }(UIStackView())

  static var socialStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.spacing = 16
    $0.addArrangedSubview(instStackView)
    $0.addArrangedSubview(twitStackView)
    return $0
  }(UIStackView())

  // MARK: - First Line
  static let firstLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = 0.9
    return $0
  }(UIView())

  // MARK: - Likes, Downloads, Downloads button
  static let heartImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "heart.fill")
    $0.tintColor = .white
    $0.alpha = 0.9
    return $0
  }(UIImageView())

  static var likesLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  static var likesStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 8
    $0.addArrangedSubview(heartImageView)
    $0.addArrangedSubview(likesLabel)
    return $0
  }(UIStackView())

  static let downloadsImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "tray.and.arrow.down.fill")
    $0.tintColor = .white
    $0.alpha = 0.9
    return $0
  }(UIImageView())

  static var downloadsLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  static var downloadStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 8
    $0.addArrangedSubview(downloadsImageView)
    $0.addArrangedSubview(downloadsLabel)
    return $0
  }(UIStackView())

  static var profitabilityStackViews: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.spacing = 32
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    return $0
  }(UIStackView())

  static let downloadButton: UIButton = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 8
    $0.setTitle(" JPEG", for: .normal)
    $0.setImage(UIImage(systemName: "arrow.down.app.fill"), for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    $0.tintColor = .darkGray
    $0.alpha = 0.4
    $0.setContentHuggingPriority(.required, for: .horizontal)
    $0.widthAnchor.constraint(equalToConstant: 74).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
    return $0
  }(UIButton(type: .system))

  static var profitAndDownloadButtonStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .fill
    $0.spacing = 16
    $0.addArrangedSubview(profitabilityStackViews)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(downloadButton)
    return $0
  }(UIStackView())

  // MARK: - Second Line
  static let secondLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = 0.9
    return $0
  }(UIView())

  // MARK: - Created,
  static var createdLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  // MARK: - Camera model
  static let cameraImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "camera.viewfinder")
    $0.tintColor = .white
    $0.widthAnchor.constraint(equalToConstant: 24).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
    $0.alpha = 0.9
    return $0
  }(UIImageView())

  static var cameraModelLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .black)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  static var cameraStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 4
    $0.addArrangedSubview(cameraImageView)
    $0.addArrangedSubview(cameraModelLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: - Photo size
  static var mPxLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  static var pxLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  static var photoResolutionStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 0
    $0.addArrangedSubview(mPxLabel)
    $0.addArrangedSubview(pxLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: - Characteristics of photography
  static var isoLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  static var apertureLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  static var focalLengthLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  static var exposureTimeLabel: UILabel = {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  static var characteristicsOfPhotographyStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 0
    $0.addArrangedSubview(isoLabel)
    $0.addArrangedSubview(focalLengthLabel)
    $0.addArrangedSubview(apertureLabel)
    $0.addArrangedSubview(exposureTimeLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // MARK: -
  static let vStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = 16
    $0.addArrangedSubview(profilePhotoNameLocationStackView)
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
}
