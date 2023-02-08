// MethodType.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Константы
private enum Constants {
    static let popularMethodKey = "popular"
    static let upcomingMethodKey = "upcoming"
    static let topRatedMethodKey = "top_rated"
}

/// Списки фильмов
enum MethodType {
    case popularMethod
    case upcomingMethod
    case topRatedMethod
}

/// Расширение для типов методов
extension MethodType {
    var method: String {
        switch self {
        case .popularMethod:
            return Constants.popularMethodKey
        case .upcomingMethod:
            return Constants.upcomingMethodKey
        case .topRatedMethod:
            return Constants.topRatedMethodKey
        }
    }
}
