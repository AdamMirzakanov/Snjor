//
//  SettingsViewControllerRootView.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 09.10.2024.
//

import UIKit

fileprivate typealias Const = SettingsViewControllerRootViewConst

final class SettingsViewControllerRootView: UIView {
  
  // MARK: Views
  private let scrollView: UIScrollView = {
    $0.alwaysBounceVertical = true
    return $0
  }(UIScrollView())
  
  private let switcher: UISwitch = {
    $0.onTintColor = .systemRed
    return $0
  }(UISwitch())
  
  private let firstLineView: UIView = {
    $0.backgroundColor = .systemGray
    $0.heightAnchor.constraint(
      equalToConstant: 1
    ).isActive = true
    return $0
  }(UIView())
  
  private let secondLineView: UIView = {
    $0.backgroundColor = .systemGray
    $0.heightAnchor.constraint(
      equalToConstant: 1
    ).isActive = true
    return $0
  }(UIView())
  
  private let thirdLineView: UIView = {
    $0.backgroundColor = .systemGray
    $0.heightAnchor.constraint(
      equalToConstant: 1
    ).isActive = true
    return $0
  }(UIView())
  
  // MARK: UILabel
  private let searchFiltersLabel: UILabel = {
    $0.text = "Search filters"
    $0.textColor = Const.colorOfTheSectionTitle
    $0.textAlignment = Const.sectionTitleTextAlignment
    $0.font = Const.fontOfTheSectionTitle
    return $0
  }(UILabel())
  
  private let colorFiltersLabel: UILabel = {
    $0.text = "Color filters"
    $0.textColor = Const.colorOfTheSectionTitle
    $0.textAlignment = Const.sectionTitleTextAlignment
    $0.font = Const.fontOfTheSectionTitle
    return $0
  }(UILabel())
  
  private let layoutLabel: UILabel = {
    $0.text = "Layout"
    $0.textColor = Const.colorOfTheSectionTitle
    $0.textAlignment = Const.sectionTitleTextAlignment
    $0.font = Const.fontOfTheSectionTitle
    return $0
  }(UILabel())
  
  private let languageLabel: UILabel = {
    $0.text = "Language"
    $0.textColor = Const.colorOfTheSectionTitle
    $0.textAlignment = Const.sectionTitleTextAlignment
    $0.font = Const.fontOfTheSectionTitle
    return $0
  }(UILabel())
  
  private let orientationLabel: UILabel = {
    $0.text = "Orientation"
    $0.textColor = Const.systemGray
    $0.textAlignment = Const.standartTextAlignment
    $0.font = Const.standardFont
    return $0
  }(UILabel())
  
  private let contentFilterLabel: UILabel = {
    $0.text = "Content"
    $0.textColor = Const.systemGray
    $0.textAlignment = Const.standartTextAlignment
    $0.font = Const.standardFont
    return $0
  }(UILabel())
  
  private let sortingPhotosLabel: UILabel = {
    $0.text = "Sorting"
    $0.textColor = Const.systemGray
    $0.textAlignment = Const.standartTextAlignment
    $0.font = Const.standardFont
    return $0
  }(UILabel())
  
  private let numberOfColumnsLabel: UILabel = {
    $0.text = "Columns"
    $0.textColor = Const.systemGray
    $0.textAlignment = Const.standartTextAlignment
    $0.font = Const.standardFont
    return $0
  }(UILabel())
  
  private let chooseLanguageLabel: UILabel = {
    $0.text = "Select a language"
    $0.textColor = Const.systemGray
    $0.textAlignment = Const.standartTextAlignment
    $0.font = Const.standardFont
    return $0
  }(UILabel())
  
  // MARK: Bottons
  private let purpleCircleButton: UIButton = {
    $0.setImage(Const.colorImageView, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemPurple
    $0.addTarget(
      self,
      action: #selector(colorCircleButtonTapped),
      for: .touchUpInside
    )
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let greenCircleButton: UIButton = {
    $0.setImage(Const.colorImageView, for: .normal)
    $0.tintColor = .systemGreen
    $0.addTarget(
      self,
      action: #selector(colorCircleButtonTapped),
      for: .touchUpInside
    )
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let yellowCircleButton: UIButton = {
    $0.setImage(Const.colorImageView, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemYellow
    $0.addTarget(
      self,
      action: #selector(colorCircleButtonTapped),
      for: .touchUpInside
    )
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let orangeCircleButton: UIButton = {
    $0.setImage(Const.colorImageView, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemOrange
    $0.addTarget(
      self,
      action: #selector(colorCircleButtonTapped),
      for: .touchUpInside
    )
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let redCircleButton: UIButton = {
    $0.setImage(Const.colorImageView, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemPink
    $0.addTarget(
      self,
      action: #selector(colorCircleButtonTapped),
      for: .touchUpInside
    )
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let tealCircleButton: UIButton = {
    $0.setImage(Const.colorImageView, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemTeal
    $0.addTarget(
      self,
      action: #selector(colorCircleButtonTapped),
      for: .touchUpInside
    )
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let blueCircleButton: UIButton = {
    $0.setImage(Const.colorImageView, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .systemBlue
    $0.addTarget(
      self,
      action: #selector(colorCircleButtonTapped),
      for: .touchUpInside
    )
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let blackAndWhiteCircleButton: UIButton = {
    $0.setImage(Const.colorImageView, for: .normal)
    $0.alpha = Const.colorCirclOpasity
    $0.tintColor = .white
    $0.addTarget(
      self,
      action: #selector(colorCircleButtonTapped),
      for: .touchUpInside
    )
    let scaleTransform = CGAffineTransform(
      scaleX: Const.colorCircleButtonScale,
      y: Const.colorCircleButtonScale
    )
    $0.transform = scaleTransform
    return $0
  }(UIButton(type: .system))
  
  private let resetButton: UIButton = {
    $0.setTitle("Reset", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.titleLabel?.font = Const.standardFont
    $0.layer.cornerRadius = 10
    $0.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    $0.clipsToBounds = true
    $0.backgroundColor = Const.resetButtonColor
    $0.addTarget(
      self,
      action: #selector(resetButtonTapped),
      for: .touchUpInside
    )
    return $0
  }(UIButton())
  
  @objc private func colorCircleButtonTapped(_ sender: UIButton) {
    animateColorCircleButton(sender)
  }
  
  @objc private func resetButtonTapped(_ sender: UIButton) {
    print(3456789)
    animateResetButton(sender)
  }
  
  // MARK: UISegmentedControl
  private lazy var orientationSegmentControl: UISegmentedControl = {
    $0.selectedSegmentTintColor = Const.selectedSegmentTintColor
    $0.selectedSegmentIndex = .zero
    $0.addTarget(
      self,
      action: #selector(aspectRatioChanged),
      for: .valueChanged
    )
    return $0
  }(UISegmentedControl(
    items: [
      "All",
      UIImage(systemName: "rectangle.ratio.4.to.3")!,
      UIImage(systemName: "rectangle.ratio.3.to.4")!,
      UIImage(systemName: "square")!
    ]
  ))
  
  private lazy var contentFilterSegmentControl: UISegmentedControl = {
    $0.selectedSegmentTintColor = Const.selectedSegmentTintColor
    $0.selectedSegmentIndex = .zero
    return $0
  }(UISegmentedControl(
    items: [
      "Low",
      "High"
    ]
  ))
  
  private lazy var sortingPhotosSegmentControl: UISegmentedControl = {
    $0.selectedSegmentTintColor = Const.selectedSegmentTintColor
    $0.selectedSegmentIndex = .zero
    return $0
  }(UISegmentedControl(
    items: [
      "Relevant",
      "Latest"
    ]
  ))
  
  private lazy var numberOfColumnsSegmentControl: UISegmentedControl = {
    $0.selectedSegmentTintColor = Const.selectedSegmentTintColor
    $0.selectedSegmentIndex = .zero
    return $0
  }(UISegmentedControl(
    items: [
      "2",
      "3",
      "4"
    ]
  ))
  
  private lazy var languageSegmentControl: UISegmentedControl = {
    $0.selectedSegmentTintColor = Const.selectedSegmentTintColor
    $0.selectedSegmentIndex = .zero
    return $0
  }(UISegmentedControl(
    items: [
      "English",
      "Русский",
      "한국어"
    ]
  ))
  
  @objc private func aspectRatioChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      print("All")
    case 1:
      print("Landscape")
    case 2:
      print("Portrait")
    case 3:
      print("Squarish")
    default:
      break
    }
  }

  // MARK: UIStackView
  private lazy var colorsStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.addArrangedSubview(blackAndWhiteCircleButton)
    $0.addArrangedSubview(greenCircleButton)
    $0.addArrangedSubview(yellowCircleButton)
    $0.addArrangedSubview(orangeCircleButton)
    $0.addArrangedSubview(redCircleButton)
    $0.addArrangedSubview(purpleCircleButton)
    $0.addArrangedSubview(blueCircleButton)
    $0.addArrangedSubview(tealCircleButton)
    return $0
  }(UIStackView())
  
//  private lazy var colorsSectionStackView: UIStackView = {
//    $0.axis = .horizontal
//    $0.alignment = .center
////    $0.addArrangedSubview(chooseColorLabel)
//    $0.addArrangedSubview(colorsStackView)
//    return $0
//  }(UIStackView())
  
  private lazy var colorsSectionStackView: UIStackView = {
    $0.axis = .vertical
    $0.spacing = 20
    $0.addArrangedSubview(colorFiltersLabel)
    $0.addArrangedSubview(colorsStackView)
    return $0
  }(UIStackView())
  
  private lazy var orientationStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.addArrangedSubview(orientationLabel)
    $0.addArrangedSubview(orientationSegmentControl)
    return $0
  }(UIStackView())
  
  private lazy var contentFilterStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.addArrangedSubview(contentFilterLabel)
    $0.addArrangedSubview(contentFilterSegmentControl)
    return $0
  }(UIStackView())
  
  private lazy var sortingPhotosStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.addArrangedSubview(sortingPhotosLabel)
    $0.addArrangedSubview(sortingPhotosSegmentControl)
    return $0
  }(UIStackView())
  
  private lazy var numberOfColumnsStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.addArrangedSubview(numberOfColumnsLabel)
    $0.addArrangedSubview(numberOfColumnsSegmentControl)
    return $0
  }(UIStackView())
  
  private lazy var languageStackView: UIStackView = {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
//    $0.addArrangedSubview(chooseLanguageLabel)
    $0.addArrangedSubview(languageSegmentControl)
    return $0
  }(UIStackView())
  
  private lazy var mainStackView: UIStackView = {
    $0.axis = .vertical
    $0.spacing = 20
    $0.addArrangedSubview(searchFiltersLabel)
    $0.addArrangedSubview(contentFilterStackView)
    $0.addArrangedSubview(orientationStackView)
    $0.addArrangedSubview(sortingPhotosStackView)
    $0.addArrangedSubview(firstLineView)
    $0.addArrangedSubview(colorsSectionStackView)
    $0.addArrangedSubview(secondLineView)
    $0.addArrangedSubview(layoutLabel)
    $0.addArrangedSubview(numberOfColumnsStackView)
    $0.addArrangedSubview(thirdLineView)
    $0.addArrangedSubview(languageLabel)
    $0.addArrangedSubview(languageStackView)
    $0.addArrangedSubview(resetButton)
    return $0
  }(UIStackView())
  
  // MARK: - Initializers
  init() {
    super.init(frame: .zero)
    setupViews()
    
    switcher.addTarget(
      self,
      action: #selector(switchChanged),
      for: .valueChanged
    )
    
//    backgroundColor = .white
  }
  
  required init?(coder: NSCoder) {
    fatalError(.requiredInitFatalErrorText)
  }
  
  // MARK: Setup Views
  private func setupViews() {
    addSubviews()
    setupConstraints()
  }
  
  private func addSubviews() {
    addSubview(scrollView)
    scrollView.addSubview(mainStackView)
  }
  
  private func setupConstraints() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(
        equalTo: scrollView.topAnchor,
        constant: 15
      ),
      mainStackView.leadingAnchor.constraint(
        equalTo: scrollView.leadingAnchor,
        constant: 20
      ),
      mainStackView.trailingAnchor.constraint(
        equalTo: scrollView.trailingAnchor,
        constant: -20
      ),
      mainStackView.bottomAnchor.constraint(
        equalTo: scrollView.bottomAnchor
      ),
      mainStackView.widthAnchor.constraint(
        equalTo: safeAreaLayoutGuide.widthAnchor,
        constant: -40
      )
    ])
  }
  
  @objc private func switchChanged(_ sender: UISwitch) {
    let selectedOrientation: String
    if sender.isOn {
      selectedOrientation = "landscape"
    } else {
      selectedOrientation = "squarish"
    }
    UserDefaults.standard.set(selectedOrientation, forKey: "photoOrientation")
  }
  
  // MARK: Animate Buttons
  private func animateColorCircleButton(_ sender: UIButton) {
    UIView.animate(withDuration: Const.duration) {
      let scaleTransform = CGAffineTransform(
        scaleX: Const.pressingColorCircleButtonScale,
        y: Const.pressingColorCircleButtonScale
      )
      sender.transform = scaleTransform
    } completion: { _ in
      UIView.animate(withDuration: Const.duration) {
        let scaleTransform = CGAffineTransform(
          scaleX: Const.colorCircleButtonScale,
          y: Const.colorCircleButtonScale
        )
        sender.transform = scaleTransform
      }
    }
  }
  
  private func animateResetButton(_ sender: UIButton) {
    UIView.animate(withDuration: Const.duration) {
      let scaleTransform = CGAffineTransform(
        scaleX: Const.pressingResetButtonScale,
        y: Const.pressingResetButtonScale
      )
      sender.transform = scaleTransform
    } completion: { _ in
      UIView.animate(withDuration: Const.duration) {
        sender.transform = .identity
      }
    }
  }
}

enum SettingsViewControllerRootViewConst {
  static let colorImageViewSize: CGFloat = 30.0
  static let colorImageView: UIImage = UIImage(systemName: "circle")!
  static let colorCirclOpasity: CGFloat = 1.0
  static let pressingResetButtonScale: CGFloat = 0.95
  static let pressingColorCircleButtonScale: CGFloat = 0.9
  static let colorCircleButtonScale: CGFloat = 1.2
  static let duration: CGFloat = 0.12
  static let selectedSegmentTintColor: UIColor = .systemBlue
  static let resetButtonColor: UIColor = .systemPink
  static let fontOfTheSectionTitle: UIFont = .systemFont(ofSize: 25, weight: .bold)
  static let standardFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
  static let colorOfTheSectionTitle: UIColor = .systemGray3
  static let systemGray: UIColor = .systemGray
  static let sectionTitleTextAlignment: NSTextAlignment = .left
  static let standartTextAlignment: NSTextAlignment = .left
}
