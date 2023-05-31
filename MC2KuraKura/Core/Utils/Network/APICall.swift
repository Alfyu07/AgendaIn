//
//  APICall.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import Foundation

struct API {
    static let baseUrl = "https://www.google.com/"
}

protocol Endpoint {
    var url: String {get}
}
enum Endpoints {

  enum Gets: Endpoint {
    case login
    case meetings
    case vote
    case search

    public var url: String {
      switch self {
      case .login: return "\(API.baseUrl)categories.php"
      case .meetings: return "\(API.baseUrl)filter.php?c="
      case .vote: return "\(API.baseUrl)lookup.php?i="
      case .search: return "\(API.baseUrl)search.php?s="
      }
    }
  }

}
