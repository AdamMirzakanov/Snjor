//
//  PhotoDetailViewController.swift
//  Snjor
//
//  Created by Адам on 18.06.2024.
//

import UIKit
import Combine
import Photos

// swiftlint:disable all
class PhotoDetailViewController: UIViewController {
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private let viewModel: any PhotoDetailViewModelProtocol
  private var isAspectFill = true
  private var isPhotoInfo = true

  // MARK: - Download
  let documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!

  let downloadService = DownloadService()

  lazy var downloadsSession: URLSession = {
    let configuration = URLSessionConfiguration.background(
      withIdentifier: "com.raywenderlich.HalfTunes.bgSession"
    )
    return URLSession(
      configuration: configuration,
      delegate: self,
      delegateQueue: nil
    )
  }()

//  func localFilePath(for url: URL) -> URL {
//    return documentsPath.appendingPathComponent(url.lastPathComponent)
//  }

  func localFilePath(for url: URL) -> URL {
      var destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
      if destinationURL.pathExtension.isEmpty {
          destinationURL = destinationURL.appendingPathExtension("jpg")
      }
      return destinationURL
  }

  // MARK: - Views
  private let uiContainerView: ContainerView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .systemBackground
    return $0
  }(ContainerView())

  // MARK: - Back Bar Button
  private let backBarButtonBlurView: UIVisualEffectView = {
    $0.frame = CGRect(
      x: .zero,
      y: .zero,
      width: UIConst.buttonHeight,
      height: UIConst.buttonHeight
    )
    $0.layer.cornerRadius = UIConst.backButtonBlurViewCornerRadius
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  private lazy var backBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .backBarButtonImage), for: .normal)
    $0.tintColor = .label
    $0.alpha = UIConst.alpha
    $0.frame = backBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: - Download Bar Button
  private let downloadBarButtonBlurView: UIVisualEffectView = {
    $0.frame = CGRect(
      x: .zero,
      y: .zero,
      width: UIConst.buttonWidth,
      height: UIConst.buttonHeight
    )
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  private lazy var downloadBarButton: UIButton = {
    $0.setImage(UIImage(systemName: .downloadBarButtonImage), for: .normal)
    $0.setTitle(.jpeg, for: .normal)
    $0.titleLabel?.font = .systemFont(
      ofSize: UIConst.defaultFontSize,
      weight: .regular
    )
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alpha
    $0.frame = downloadBarButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: - Toggle Content Mode Button
  private let toggleContentModeButtonBlurView: UIVisualEffectView = {
    $0.frame = CGRect(
      x: .zero,
      y: .zero,
      width: UIConst.buttonHeight,
      height: UIConst.buttonHeight
    )
    $0.layer.cornerRadius = UIConst.defaultValue
    $0.clipsToBounds = true
    return $0
  }(UIVisualEffectView(effect: UIBlurEffect(style: .regular)))

  private lazy var toggleContentModeButton: UIButton = {
    let icon = UIImage(systemName: .arrowUp)
    $0.setImage(icon, for: .normal)
    $0.tintColor = .label
    $0.setTitleColor(.label, for: .normal)
    $0.alpha = UIConst.alpha
    $0.frame = toggleContentModeButtonBlurView.bounds
    return $0
  }(UIButton(type: .custom))

  // MARK: - Initializers
  init(viewModel: any PhotoDetailViewModelProtocol
  ) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    stateController()
    configData()
    hidePhotoInfo()
//    viewModel.viewDidLoad()
    downloadService.downloadsSession = downloadsSession
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.hideCustomTabBar()
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let tabBar = tabBarController as? MainTabBarController {
      tabBar.showCustomTabBar()
    }
  }

  // MARK: - Private Methods
  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
        self.hideSpinner()
        switch state {
        case .success:
          self.configData()
        case .loading:
          //          self.showSpinner()
          print()
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
          self.hideSpinner()
        }
      }
      .store(in: &cancellable)
  }

  private func configData() {
    uiContainerView.setupView()
    uiContainerView.mainPhotoImageView.setImageFromData(data: viewModel.backgroundImageData)
    uiContainerView.profilePhotoImageView.setImageFromData(data: viewModel.backgroundImageData)
    uiContainerView.nameLabel.text = viewModel.displayName
    uiContainerView.likesLabel.text = viewModel.likes
    uiContainerView.downloadsLabel.text = viewModel.downloads
    uiContainerView.viewsLabel.text = viewModel.views
    uiContainerView.createdAt(from: viewModel.createdAt)
    uiContainerView.cameraModelLabel.text = viewModel.cameraModel
    uiContainerView.resolutionLabel.text = viewModel.resolution
    uiContainerView.pxLabel.text = viewModel.pixels
    uiContainerView.isoLabel.text = viewModel.iso
    uiContainerView.focalLengthLabel.text = viewModel.focalLength
    uiContainerView.apertureLabel.text = viewModel.aperture
    uiContainerView.exposureTimeLabel.text = viewModel.exposureTime
  }

  private func setupUI() {
    setupBarButtonItems()
    configActions()
    view.addSubview(uiContainerView)
    NSLayoutConstraint.activate([
      uiContainerView.topAnchor.constraint(equalTo: view.topAnchor),
      uiContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      uiContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      uiContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  private func setupBarButtonItems() {
    let toggleContentModeButton = makeToggleContentModeButton()
    let downloadBarButton = makeDownloadBarButton()
    let backBarButton = makeBackBarButton()
    navigationItem.rightBarButtonItems = [toggleContentModeButton, downloadBarButton]
    navigationItem.leftBarButtonItems = [backBarButton]
  }

  private func makeBackBarButton() -> UIBarButtonItem {
    backBarButtonBlurView.contentView.addSubview(backBarButton)
    return UIBarButtonItem(customView: backBarButtonBlurView)
  }

  private func makeDownloadBarButton() -> UIBarButtonItem {
    downloadBarButtonBlurView.contentView.addSubview(downloadBarButton)
    return UIBarButtonItem(customView: downloadBarButtonBlurView)
  }

  private func makeToggleContentModeButton() -> UIBarButtonItem {
    toggleContentModeButtonBlurView.contentView.addSubview(toggleContentModeButton)
    return UIBarButtonItem(customView: toggleContentModeButtonBlurView)
  }


  // MARK: -

  private func configActions() {
    configInfoButtonAction()
    configBackButtonAction()
    configDownloadButtonAction()
    configToggleContentModeButtonAction()
  }

  private func configInfoButtonAction() {
    let infoButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      self.isPhotoInfo ? self.showPhotoInfo() : self.hidePhotoInfo()
      self.isPhotoInfo.toggle()
    }
    uiContainerView.infoButton.addAction(infoButtonAction, for: .touchUpInside)
  }

  private func configBackButtonAction() {
    let backButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      self.navigationController?.popViewController(animated: true)
    }
    backBarButton.addAction(backButtonAction, for: .touchUpInside)
  }

  private func configDownloadButtonAction() {
    let downloadButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      //code:
      downloadService.startDownload(viewModel.photo!)
      UIView.animate(withDuration: 1) {
        self.downloadBarButtonBlurView.transform = 
      }
    }
    downloadBarButton.addAction(downloadButtonAction, for: .touchUpInside)
  }

  private func configToggleContentModeButtonAction() {
    let toggleContentModeButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
      if self.isAspectFill {
        let icon = UIImage(systemName: .arrowDown)
        self.uiContainerView.mainPhotoImageView.contentMode = .scaleAspectFit
        self.toggleContentModeButton.setImage(icon, for: .normal)
      } else {
        let icon = UIImage(systemName: .arrowUp)
        self.uiContainerView.mainPhotoImageView.contentMode = .scaleAspectFill
        self.toggleContentModeButton.setImage(icon, for: .normal)
      }
      self.isAspectFill.toggle()
    }
    toggleContentModeButton.addAction(toggleContentModeButtonAction, for: .touchUpInside)
  }

  private func hidePhotoInfo() {
    UIView.animate(withDuration: 0.3) {
      self.uiContainerView.profileStackView.transform = CGAffineTransform(translationX: 0, y: -10)
      self.uiContainerView.photoInfoStackView.alpha = 0
      self.uiContainerView.gradientView.alpha = 0.4
      self.uiContainerView.photoInfoStackView.isHidden = true
    }
  }

  private func showPhotoInfo() {
    UIView.animate(
      withDuration: 0.7,
      delay: 0,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 0.5
    ) {
      self.uiContainerView.gradientView.alpha = 1
      self.uiContainerView.photoInfoStackView.alpha = 1
      self.uiContainerView.mainStackView.transform = .identity
      self.uiContainerView.photoInfoStackView.isHidden = false
    }
  }


  private func saveImageToGallery(at url: URL) {
    PHPhotoLibrary.requestAuthorization { status in
      guard status == .authorized else {
        print("Photo library access not authorized.")
        return
      }

      PHPhotoLibrary.shared().performChanges({
        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
      }) { success, error in
        if success {
          print("Successfully saved image to gallery.")
        } else if let error = error {
          print("Error saving image to gallery: \(error)")
        }
      }
    }
  }

}

// MARK: - MessageDisplayable
extension PhotoDetailViewController: MessageDisplayable { }

// MARK: - SpinnerDisplayable
extension PhotoDetailViewController: SpinnerDisplayable { }

// MARK: - URL Session Delegate
extension PhotoDetailViewController: URLSessionDelegate {
  func urlSessionDidFinishEvents(
    forBackgroundURLSession session: URLSession
  ) {
    DispatchQueue.main.async {
      if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
         let completionHandler = appDelegate.backgroundSessionCompletionHandler {
        appDelegate.backgroundSessionCompletionHandler = nil
        completionHandler()
      }
    }
  }
}

// MARK: - URL Session Download Delegate
extension PhotoDetailViewController: URLSessionDownloadDelegate {
  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didFinishDownloadingTo location: URL
  ) {

    guard let sourceURL = downloadTask.originalRequest?.url
    else {
      return
    }

    let download = downloadService.activeDownloads[sourceURL]
    downloadService.activeDownloads[sourceURL] = nil

    let destinationURL = localFilePath(for: sourceURL)
    print(destinationURL)

    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)

    do {
      try fileManager.copyItem(at: location, to: destinationURL)
      saveImageToGallery(at: destinationURL)
    } catch let error {
      print("Could not copy file to disk: \(error.localizedDescription)")
    }
  }

  func urlSession(
    _ session: URLSession,
    downloadTask: URLSessionDownloadTask,
    didWriteData bytesWritten: Int64,
    totalBytesWritten: Int64,
    totalBytesExpectedToWrite: Int64
  ) {
    guard
      let url = downloadTask.originalRequest?.url,
      let download = downloadService.activeDownloads[url]
    else {
      return
    }

    download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)

    let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
  }
}
