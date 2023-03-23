//
//  APIError.swift
//  Networking
//
//  Created by YHAN on 2023/03/19.
//

import Foundation

public enum APIError: Error {
  case unknown
  case badRequest
  case unauthorized
  case forbidden
  case notFound
  case serverError

  init(statusCode: Int) {
    switch statusCode {
    case 400:
      self = .badRequest
    case 401:
      self = .unauthorized
    case 403:
      self = .forbidden
    case 404:
      self = .notFound
    case 500...599:
      self = .serverError
    default:
      self = .unknown
    }
  }

  var localizedDescription: String {
    switch self {
    case .badRequest:
      return "잘못된 요청입니다."
    case .unauthorized:
      return "인증되지 않은 요청입니다."
    case .forbidden:
      return "권한이 없는 요청입니다."
    case .notFound:
      return "요청한 리소스를 찾을 수 없습니다."
    case .serverError:
      return "서버에서 예상치 못한 오류가 발생했습니다."
    case .unknown:
      return "알 수 없는 오류가 발생했습니다."
    }
  }
}
