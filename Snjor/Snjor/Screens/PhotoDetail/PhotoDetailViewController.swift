//
//  PhotoDetailViewController.swift
//  Snjor
//
//  Created by Адам on 18.06.2024.
//

import UIKit
import Combine

// swiftlint:disable all
class PhotoDetailViewController: UIViewController {

  private var cancellable = Set<AnyCancellable>()
  private let viewModel: PhotoDetailViewModel
  let iso860Formatter = ISO8601DateFormatter()

  init(viewModel: PhotoDetailViewModel
  ) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: -
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    stateController()
    viewModel.viewDidLoad()
  }

  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        self.hideSpinner()
        switch state {
        case .success:
          print(viewModel.iso)
          guard let photo = viewModel.photo else { return }
          updateUI(with: photo)
        case .loading:
          self.showSpinner()
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
        }
      }
      .store(in: &cancellable)
  }

  private func updateUI(with photo: Photo) {
    UIComponents.photoView.setupImageView()
    UIComponents.photoView.configure(with: photo)
    UIComponents.nameLabel.text = photo.user.displayName
    UIComponents.locationLabel.text = photo.user.location
    UIComponents.likesLabel.text = String(photo.likes)
    UIComponents.downloadsLabel.text = String(photo.downloads ?? 0)
    UIComponents.cameraModelLabel.text = photo.exif?.model ?? "-"
    UIComponents.pxLabel.text = "\(photo.width) × \(photo.height) "
    UIComponents.isoLabel.text = "ISO " + "\(photo.exif?.iso ?? 0) • "
    UIComponents.focalLengthLabel.text = (photo.exif?.focalLength ?? "-") + " mm • "
    UIComponents.apertureLabel.text = "𝑓 " + "\(photo.exif?.aperture ?? "-") • "
    UIComponents.exposureTimeLabel.text = (photo.exif?.exposureTime ?? "-") + " s"
    UIComponents.mPxLabel.text = megaPixels()
    UIComponents.instUsernameLabel.text = photo.user.social?.instagramUsername ?? "-"
    UIComponents.twitUsernameLabel.text = photo.user.social?.twitterUsername ?? "-"
    createdAt(from: photo.createdAt)
  }

  func createdAt(from date: String) {
    guard let date = iso860Formatter.date(from: date) else { return }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    let readableDate = dateFormatter.string(from: date)
    UIComponents.createdLabel.text = readableDate
  }

  func totalPixels() -> Int {
    guard let photo = viewModel.photo else { return 0 }
    return photo.width * photo.height
  }

  func megaPixels() -> String {
    let totalPixels = self.totalPixels()
    let megaPixels = totalPixels / 1_000_000
    return String(megaPixels) + " MP • "
  }

  func setupUI() {
//    view.backgroundColor = .systemBackground
    view.addSubview(UIComponents.photoView)
    view.addSubview(UIComponents.gradientView)
    view.addSubview(UIComponents.vStackView)

    NSLayoutConstraint.activate([
      UIComponents.gradientView.topAnchor.constraint(equalTo: view.topAnchor),
      UIComponents.gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      UIComponents.gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      UIComponents.gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      UIComponents.photoView.topAnchor.constraint(equalTo: view.topAnchor),
      UIComponents.photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
      UIComponents.photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      UIComponents.photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      UIComponents.vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      UIComponents.vStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),

      // размеры аватарки
      UIComponents.profilePhotoImageView.widthAnchor.constraint(equalToConstant: 54),
      UIComponents.profilePhotoImageView.heightAnchor.constraint(equalToConstant: 54),

      // размеры срединной линии
      UIComponents.firstLine.heightAnchor.constraint(equalToConstant: 1),
      UIComponents.firstLine.widthAnchor.constraint(equalToConstant: view.frame.width - 32),

      // размеры нижней линии
      UIComponents.secondLine.heightAnchor.constraint(equalToConstant: 1),
      UIComponents.secondLine.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
    ])
  }
}

extension PhotoDetailViewController: MessageDisplayable { }
extension PhotoDetailViewController: SpinnerDisplayable { }
