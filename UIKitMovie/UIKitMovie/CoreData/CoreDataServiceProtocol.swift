// CoreDataServiceProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import CoreData

/// Протокол сервиса базы данных
protocol CoreDataServiceProtocol {
    var errorCoreDataAlert: AlertHandler? { get set }

    func saveData(movies: [Movie], moviesType: MethodType)
    func getData(moviesType: MethodType) -> [MovieData]
}
