// DetailMovieViewModelProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Протокол вью модели описания фильма
protocol DetailMovieViewModelProtocol {
    var film: MovieData? { get set }
    var errorAlert: ErrorHandler? { get set }

    func fetchImage(url: String, handler: @escaping DataHandler)
}
