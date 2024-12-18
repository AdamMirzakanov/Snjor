//
//  PrepareParameters + PrepareParametersProtocol.swift
//  Snjor
//
//  Created by Адам Мирзаканов on 18.12.2024.
//

extension PrepareParameters: PrepareParametersProtocol {
  func preparePhotosParameters() -> Parameters {
    nextPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(Self.photosPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
 
  func prepareAlbumParameters() -> Parameters {
    nextAlbumsPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(Self.albumsPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
 
  func prepareUserLikedPhotosParameters() -> Parameters {
    nextUserLikedPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(Self.userLikedPhotosPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
 
  func prepareUserPhotosParameters() -> Parameters {
    nextUserPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(Self.userPhotosPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
 
  func prepareRandomUserPhotoParameters(username: String) -> Parameters {
    var parameters: Parameters = [:]
    parameters[ParamKey.username.rawValue] = username
    parameters[ParamKey.orientation.rawValue] = ParamValue.portrait.rawValue
    return parameters
  }
 
  func prepareUserAlbumsParameters() -> Parameters {
    nextUserAlbumsPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.page.rawValue] = String(Self.userAlbumsPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
 
  func prepareSearchPhotoParameters(with searchTerm: String) -> Parameters {
    nextSearchPhotosPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.query.rawValue] = searchTerm
    parameters[ParamKey.page.rawValue] = String(Self.searchPhotosPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    
    if let orientation = storage.string(forKey: .photoOrientationKey) {
      parameters[ParamKey.orientation.rawValue] = orientation
    }
    
    if let contentFilter = storage.string(forKey: .sortingPhotosKey) {
      parameters[ParamKey.orderBy.rawValue] = contentFilter
    }
    
    if let color = storage.string(forKey: .selectedCircleButtonKey) {
      switch color {
      case ParamValue.blackAndWhite.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.green.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.yellow.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.orange.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.red.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.purple.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.blue.rawValue:
        parameters[ParamKey.color.rawValue] = color
      case ParamValue.teal.rawValue:
        parameters[ParamKey.color.rawValue] = color
      default:
        storage.remove(forKey: .selectedCircleButtonKey)
      }
    }
    return parameters
  }
 
  func prepareSearchAlbumsParameters(with searchTerm: String) -> Parameters {
    nextSearchAlbumsPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.query.rawValue] = searchTerm
    parameters[ParamKey.page.rawValue] = String(Self.searchAlbumsPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
 
  func prepareSearchUsersParameters(with searchTerm: String) -> Parameters {
    nextSearchUsersPage()
    var parameters: Parameters = [:]
    parameters[ParamKey.query.rawValue] = searchTerm
    parameters[ParamKey.page.rawValue] = String(Self.searchUsersPage)
    parameters[ParamKey.perPage.rawValue] = String(Int.perPage)
    return parameters
  }
}
