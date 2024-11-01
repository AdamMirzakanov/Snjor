//
//  SettingsViewControllerRootViewConst.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 16.10.2024.
//

import UIKit

enum SettingsViewControllerRootViewConst {
 
  static let selectedSegmentTintColor: UIColor = .systemBlue
  static let resetButtonColor: UIColor = .white
  static let colorOfTheSectionTitle: UIColor = .systemGray3
  static let systemGray: UIColor = .systemGray
  
  static let fontOfTheSectionTitle: UIFont = .systemFont(ofSize: 25, weight: .bold)
  static let standardFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
  static let resetButtonFont: UIFont = .systemFont(ofSize: 20, weight: .regular)
  
  static let sectionTitleTextAlignment: NSTextAlignment = .left
  static let standartTextAlignment: NSTextAlignment = .left
  
  static let resetButtonCornerRadius: CGFloat = 8.0
  static let resetButtonHeight: CGFloat = 40.0
  static let lineHeight: CGFloat = 1.0
  static let lineColor: UIColor = .systemGray
  static let mainStackViewSpacing: CGFloat = 20.0
  static let stackViewTopInset: CGFloat = 15.0
  static let stackViewHorizontalInset: CGFloat = 20.0
  static let stackViewWidthAdjustment: CGFloat = -40.0
  static let colorImageViewSize: CGFloat = 30.0
  static let colorCirclOpasity: CGFloat = 1.0
  static let pressingResetButtonScale: CGFloat = 0.95
  static let pressingColorCircleButtonScale: CGFloat = 0.9
  static let colorCircleButtonScale: CGFloat = 1.4
  static let duration: CGFloat = 0.12
  
  static let relevarntSegmentIndex: Int = 0
  static let latestSegmentIndex: Int = 1
  
  static let allOrientationsSegmentIndex: Int = 0
  static let landscapeOrientationSegmentIndex: Int = 1
  static let portraitOrientationSegmentIndex: Int = 2
  static let squarishOrientationSegmentIndex: Int = 3
  
  static let unColoerButton: Int = 0
  static let whiteButton: Int = 1
  static let greenButton: Int = 2
  static let yellowButton: Int = 3
  static let orangeButton: Int = 4
  static let redButton: Int = 5
  static let purpleButton: Int = 6
  static let blueButton: Int = 7
  static let tealButton: Int = 8
  
  static let resetButtonTitle: String = "Reset"
  static let colorFiltersLabelText: String = "Color filters"
  static let searchFiltersLabel: String = "Search filters"
  static let layoutLabel: String = "Layout"
  static let languageLabelText: String = "Language"
  static let orientationLabelText: String = "Orientation"
  static let contentFilterLabelText: String = "Content"
  static let sortingPhotosLabelText: String = "Sorting"
  static let numberOfColumnsLabelText: String = "Columns"
  static let chooseLanguageLabelText: String = "Select a language"
  static let lowContent: String = "Low"
  static let highContent: String = "High"
  static let relevarntSort: String = "Relevant"
  static let latestSort: String = "Latest"
  static let twoColumn: String = "2"
  static let treeColumn: String = "3"
  static let fourColumn: String = "4"
  static let all: String = "All"
}
