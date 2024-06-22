//
//  PhotoDetailViewController.swift
//  Snjor
//
//  Created by Адам on 18.06.2024.
//

import UIKit
import MapKit
import Combine

// swiftlint:disable all
class PhotoDetailViewController: UIViewController {

  private var cancellable = Set<AnyCancellable>()
  private let viewModel: PhotoDetailViewModelProtocol
  var photo: Photo?

  init(viewModel: PhotoDetailViewModel
  ) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
//  private lazy var mapView: MKMapView = {
//    let mapView = MKMapView()
//    mapView.translatesAutoresizingMaskIntoConstraints = false
//    mapView.layer.cornerRadius = 12
//    mapView.clipsToBounds = true
//    let location = CLLocationCoordinate2D(latitude: 67.331705, longitude: -122.030237)
//    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    let region = MKCoordinateRegion(center: location, span: span)
//    mapView.setRegion(region, animated: true)
//    let annotation = MKPointAnnotation()
//    annotation.coordinate = location
//    annotation.title = "Apple Park"
//    annotation.subtitle = "Cupertino, CA"
//    mapView.addAnnotation(annotation)
//    mapView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//    return mapView
//  }()

  // MARK: - Button
  private let downloadButton: UIButton = {
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

//  private let downloadButton: UIButton = {
//    $0.translatesAutoresizingMaskIntoConstraints = false
//    $0.backgroundColor = .systemBlue
//    $0.layer.cornerRadius = 8
//    $0.setTitle(" JPEG", for: .normal)
//    $0.setImage(UIImage(systemName: "arrow.down.app.fill"), for: .normal)
//    $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
//    $0.tintColor = .white
//    $0.setContentHuggingPriority(.required, for: .horizontal)
//    $0.widthAnchor.constraint(equalToConstant: 74).isActive = true
//    $0.heightAnchor.constraint(equalToConstant: 32).isActive = true
//    return $0
//  }(UIButton(type: .system))

  // MARK: -
  private let photoImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "photo")
    return $0
  }(UIImageView())

  private let gradientView: GradientView = {
    let gradientView = GradientView()
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    gradientView.setColors([
      GradientView.Color(color: .clear, location: 0.15),
      GradientView.Color(color: UIColor(white: 0, alpha: 1.0), location: 0.7)
    ])
    return gradientView
  }()

  // MARK: -

  // фото профиля
  private let profileImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "profile")
    $0.layer.cornerRadius = 27
    $0.clipsToBounds = true
    return $0
  }(UIImageView())

  // имя автора
  private lazy var nameLabel: UILabel = {
    $0.textColor = .white
    $0.text = "Adam Mirzakanov"
    $0.font = UIFont(name: "Times New Roman Bold", size: 25)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  // локация
  private lazy var locationLabel: UILabel = {
    $0.textColor = .white
    $0.text = "Russia, Nalchik"
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  // дата создания
  private lazy var createdLabel: UILabel = {
    $0.textColor = .white
    $0.text = "Четверг, 9 августа 2012г. в 1:29"
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  private let thinMidlWhiteLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = 0.9
    return $0
  }(UIView())

  private let thinBottomWhiteLine: UIView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .white
    $0.alpha = 0.9
    return $0
  }(UIView())

  // модель фотоаппарата
  private lazy var modelLabel: UILabel = {
    $0.textColor = .white
    $0.text = "NIKON D800E"
    $0.font = .systemFont(ofSize: 15, weight: .black)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  // формат фотографии
//  private lazy var jpegLabel: UILabel = {
//    $0.textColor = .white
//    $0.text = "JPEG"
//    $0.font = .systemFont(ofSize: 15, weight: .medium)
//    $0.alpha = 0.5
//    return $0
//  }(UILabel())

  // размер фотографии, например 4MP
  private lazy var mpLabel: UILabel = {
    $0.textColor = .white
    $0.text = "4 MP • "
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  // разрешение фотографии
  private lazy var sizeLabel: UILabel = {
    $0.textColor = .white
    $0.text = "3000 × 4000 px • "
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  // вес фотографии
  private lazy var mbLabel: UILabel = {
    $0.textColor = .white
    $0.text = "1.3 MB"
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  // ISO
  private lazy var isoLabel: UILabel = {
    $0.textColor = .white
    $0.text = "ISO 50 • "
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  // апертура
  private lazy var apertureLabel: UILabel = {
    $0.textColor = .white
    $0.text = "𝑓 22 • "
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  // фокусное расстояние
  private lazy var focalLengthLabel: UILabel = {
    $0.textColor = .white
    $0.text = "32 mm • "
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  // выдержка
  private lazy var exposureTimeLabel: UILabel = {
    $0.textColor = .white
    $0.text = "0.8 s"
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.5
    return $0
  }(UILabel())

  // пиктограмма лайка
  private let likesImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "heart.fill")
    $0.tintColor = .systemPink
//    $0.alpha = 0.8
    return $0
  }(UIImageView())

  // количество лайков
  private lazy var likesLabel: UILabel = {
    $0.textColor = .white
    $0.text = "10"
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  // пиктограмма загрузки
  private let downloadsImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "tray.and.arrow.down.fill")
    $0.tintColor = .white
    $0.alpha = 0.9
    return $0
  }(UIImageView())

  // количество скачиваний
  private lazy var downloadsLabel: UILabel = {
    $0.textColor = .white
    $0.text = "99"
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  // пиктограмма загрузки
  private let instagramImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "instagram")
    $0.tintColor = .white
    $0.alpha = 0.9
    $0.widthAnchor.constraint(equalToConstant: 19).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 19).isActive = true
    return $0
  }(UIImageView())

  // инстаграмм
  private lazy var instagramUsernameLabel: UILabel = {
    $0.textColor = .white
    $0.text = "instantgrammer"
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  private let twitterImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(named: "twitter")
    $0.tintColor = .white
    $0.alpha = 0.9
    $0.widthAnchor.constraint(equalToConstant: 17).isActive = true
    $0.heightAnchor.constraint(equalToConstant: 17).isActive = true
    return $0
  }(UIImageView())

  // твиттер
  private lazy var twitterUsernameLabel: UILabel = {
    $0.textColor = .white
    $0.text = "crew"
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.alpha = 0.9
    return $0
  }(UILabel())

  // MARK: - STACKS
  private lazy var instagramStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 8
    $0.addArrangedSubview(instagramImageView)
    $0.addArrangedSubview(instagramUsernameLabel)
    return $0
  }(UIStackView())

  private lazy var twitterStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 8
    $0.addArrangedSubview(twitterImageView)
    $0.addArrangedSubview(twitterUsernameLabel)
    return $0
  }(UIStackView())

  // инстаграмм и твиттер
  private lazy var instagramAndtwitterStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
//    $0.distribution = .equalSpacing
//    $0.alignment = .leading
    $0.spacing = 16
    $0.addArrangedSubview(instagramStackView)
    $0.addArrangedSubview(twitterStackView)
    return $0
  }(UIStackView())
 
  // лайки
  private lazy var likesStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 8
    $0.addArrangedSubview(likesImageView)
    $0.addArrangedSubview(likesLabel)
    return $0
  }(UIStackView())

  private lazy var downloadStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 8
    $0.addArrangedSubview(downloadsImageView)
    $0.addArrangedSubview(downloadsLabel)
    return $0
  }(UIStackView())

  // лайки и скачивания
  private lazy var likesAndDownloadStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.spacing = 32
    $0.addArrangedSubview(likesStackView)
    $0.addArrangedSubview(downloadStackView)
    return $0
  }(UIStackView())

  private lazy var likesAndDownloadAndDownloadButtonStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .fill
    $0.spacing = 16
    $0.addArrangedSubview(likesAndDownloadStackView)
    $0.addArrangedSubview(UIView())
    $0.addArrangedSubview(downloadButton)
    return $0
  }(UIStackView())

  // характеристики съемки
  private lazy var descriptionStackView: UIStackView = {
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

  // размеры и разрешение фотографии
  private lazy var sizeStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 0
    $0.addArrangedSubview(mpLabel)
    $0.addArrangedSubview(sizeLabel)
    $0.addArrangedSubview(mbLabel)
    $0.addArrangedSubview(UIView())
    return $0
  }(UIStackView())

  // имя и локация
  private lazy var nameAndLocationStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .leading
    $0.spacing = 8
    $0.addArrangedSubview(nameLabel)
    $0.addArrangedSubview(locationStackView)
    return $0
  }(UIStackView())

  // пин
  private let pinImageView: UIImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.image = UIImage(systemName: "mappin")
    $0.tintColor = .white
    $0.alpha = 0.9
    return $0
  }(UIImageView())

  // пин + локация
  private lazy var locationStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 4
    $0.addArrangedSubview(pinImageView)
    $0.addArrangedSubview(locationLabel)
    return $0
  }(UIStackView())

  // профиль + имя и локация
  private lazy var profileImageStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .center
    $0.spacing = 16
    $0.addArrangedSubview(profileImageView)
    $0.addArrangedSubview(nameAndLocationStackView)
    return $0
  }(UIStackView())

  private lazy var vStackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = 16
    $0.addArrangedSubview(profileImageStackView)
    $0.addArrangedSubview(instagramAndtwitterStackView)
    $0.addArrangedSubview(thinBottomWhiteLine)
    $0.addArrangedSubview(likesAndDownloadAndDownloadButtonStackView)
    $0.addArrangedSubview(thinMidlWhiteLine)
    $0.addArrangedSubview(createdLabel)
    $0.addArrangedSubview(modelLabel)
    $0.addArrangedSubview(sizeStackView)
    $0.addArrangedSubview(descriptionStackView)
//    $0.addArrangedSubview(mapView)
    return $0
  }(UIStackView())

  // MARK: -
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
//    stateController()
//    viewModel.viewDidLoad()
    configData()
  }

//  private func stateController() {
//    viewModel
//      .state
//      .receive(on: RunLoop.main)
//      .sink { [weak self] state in
//        guard let self = self else { return }
//        switch state {
//        case .success:
//          self.configData()
//        case .loading: break
//
//        case .fail(error: let error):
//          self.presentAlert(message: error, title: "Error")
//        }
//      }.store(in: &cancellable)
//  }

  private func configData() {
    print(#function, photo!.height)
    if let photo = photo {
      locationLabel.text = "\(photo.user.location)"
    }
  }

  func setupUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(photoImageView)
    view.addSubview(gradientView)
    view.addSubview(vStackView)

    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: view.topAnchor),
      gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      photoImageView.topAnchor.constraint(equalTo: view.topAnchor),
      photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      vStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),

      // размеры аватарки
      profileImageView.widthAnchor.constraint(equalToConstant: 54),
      profileImageView.heightAnchor.constraint(equalToConstant: 54),

      // размеры срединной линии
      thinMidlWhiteLine.heightAnchor.constraint(equalToConstant: 1),
      thinMidlWhiteLine.widthAnchor.constraint(equalToConstant: view.frame.width - 32),

      // размеры нижней линии
      thinBottomWhiteLine.heightAnchor.constraint(equalToConstant: 1),
      thinBottomWhiteLine.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
    ])
  }
}

extension PhotoDetailViewController: MessageDisplayable { }
