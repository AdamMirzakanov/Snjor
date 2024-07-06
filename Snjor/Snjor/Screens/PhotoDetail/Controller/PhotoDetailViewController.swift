//
//  PhotoDetailViewController.swift
//  Snjor
//
//  Created by Адам on 18.06.2024.
//

import UIKit
import Combine

// swiftlint:disable all
class PhotoDetailViewController: ViewController<PhotoDetailView> {
  // MARK: - Private Properties
  private var cancellable = Set<AnyCancellable>()
  private(set) var viewModel: any PhotoDetailViewModelProtocol
  private(set) var documentsPath = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
  ).first!

  // MARK: - Download
  lazy var downloadsSession: URLSession = {
    let configuration = URLSessionConfiguration.background(withIdentifier: .downloadsSessionID)
    return URLSession(
      configuration: configuration,
      delegate: self,
      delegateQueue: nil
    )
  }()

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
    configUI()
    stateController()
    fetchData()
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
  private func fetchData() {
    viewModel.viewDidLoad()
    viewModel.downloadService.downloadsSession = downloadsSession
  }

  private func stateController() {
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] state in
        guard let self = self else { return }
//        self.hideSpinner()
        switch state {
        case .success:
          self.mainView.setupData(viewModel: viewModel)
        case .loading:
          // self.showSpinner()
          print()
        case .fail(error: let error):
          self.presentAlert(message: error, title: AppLocalized.error)
//          self.hideSpinner()
        }
      }
      .store(in: &cancellable)
  }

  private func configUI() {
    mainView.setupData(viewModel: viewModel)
    mainView.setupBarButtonItems(navigationItem: navigationItem, navigationController: navigationController)
    configDownloadButtonAction()
  }

  private func configDownloadButtonAction() {
    let downloadButtonAction = UIAction { [weak self] _ in
      guard let self = self else { return }
//      self.viewModel.downloadService.startDownload(viewModel.photo!)
      self.mainView.animateDownloadButton()
//      self.showSpinner(on: self.mainView.downloadBarButtonBlurView)

//      UIView.animate(
//        withDuration: 1.3,
//        delay: 0,
//        usingSpringWithDamping: 0.4,
//        initialSpringVelocity: 0.4) {
//          self.mainView.downloadBarButtonBlurView.frame = CGRect(
//            x: UIConst.translationX,
//            y: .zero,
//            width: UIConst.buttonHeight,
//            height: UIConst.buttonHeight
//          )
//          self.mainView.downloadBarButton.frame = CGRect(
//            x: .zero,
//            y: .zero,
//            width: UIConst.buttonHeight,
//            height: UIConst.buttonHeight
//          )
//          self.mainView.downloadBarButton.setTitle(nil, for: .normal)
//          self.mainView.downloadBarButton.setImage(nil, for: .normal)
//          self.mainView.pauseBarButtonBlurView.isHidden = false
//          self.mainView.pauseBarButtonBlurView.frame = CGRect(
//            x: .zero,
//            y: .zero,
//            width: UIConst.buttonHeight,
//            height: UIConst.buttonHeight
//          )
//
//          self.mainView.pauseBarButton.frame = CGRect(
//            x: .zero,
//            y: .zero,
//            width: UIConst.buttonHeight,
//            height: UIConst.buttonHeight
//          )
//
//        } completion: { _ in
//          UIView.animate(
//            withDuration: 1.3,
//            delay: 0,
//            usingSpringWithDamping: 0.4,
//            initialSpringVelocity: 0.4) {
//              
//              
//              self.mainView.downloadBarButtonBlurView.frame = CGRect(
//                x: -UIConst.translationX,
//                y: .zero,
//                width: UIConst.buttonWidth,
//                height: UIConst.buttonHeight
//              )
//              self.mainView.downloadBarButton.frame = self.mainView.downloadBarButtonBlurView.bounds
//              self.mainView.pauseBarButtonBlurView.frame = CGRect(
//                x: .zero,
//                y: .zero,
//                width: .zero,
//                height: UIConst.buttonHeight
//              )
//              
//              self.mainView.pauseBarButton.frame = CGRect(
//                x: .zero,
//                y: .zero,
//                width: .zero,
//                height: UIConst.buttonHeight
//              )
//            }
//        }

    }
    mainView.downloadBarButton.addAction(downloadButtonAction, for: .touchUpInside)
  }
}

// MARK: - MessageDisplayable
extension PhotoDetailViewController: MessageDisplayable { }

// MARK: - SpinnerDisplayable
extension PhotoDetailViewController: SpinnerDisplayable { }
