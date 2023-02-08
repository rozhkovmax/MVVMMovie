// ListMovieStates.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Список состояния экрана
enum ListMovieStates {
    case initial
    case success
//    case success(ResultsMovie)
    case failure(Error)
}
