// ListMovieStates.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Список состояния экрана
enum ListMovieStates {
    case initial
    case success
    case failure(Error)
}
