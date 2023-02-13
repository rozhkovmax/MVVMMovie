// ListMovieViewModelProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Протокол вью модели списка фильмов
protocol ListMovieViewModelProtocol {
    var errorAlert: ErrorHandler? { get set }
    var errorCoreDataAlert: AlertHandler? { get set }
    var listMovieStates: ((ListMovieStates) -> ())? { get set }
    var listMovieProps: ListMovieStates { get set }
    var layoutHandler: VoidHandler? { get set }
    var methodType: MethodType { get set }

    func fetchMovies()
    func segmentControlAction(index: Int)
    func fetchImage(url: String, handler: @escaping DataHandler)
    func keyChainInfo() -> KeyChainServiceProtocol
    func loadMovies(method: MethodType)
}
