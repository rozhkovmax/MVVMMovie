// CoreDataService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import CoreData

/// Сервис базы данных
final class CoreDataService: CoreDataServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let errorText = "Ошибка:"
        static let coreDataModelName = "MovieData"
        static let predicateFormat = "moviesType = %@"
        static let alertTitle = "Ошибка"
        static let alertActionTitle = "OK"
    }

    // MARK: - Public Properties

    var errorCoreDataAlert: AlertHandler?

    // MARK: - Private Properties

    private let modelName: String
    private lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                self.errorCoreDataAlert?(error.localizedDescription)
            }
        }
        return container
    }()

    // MARK: - Initializers

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Public Methods

    func saveData(movies: [Movie], moviesType: MethodType) {
        guard let newMovie = NSEntityDescription.entity(
            forEntityName: Constants.coreDataModelName,
            in: managedContext
        ) else { return }
        for movie in movies {
            let newMovie = MovieData(entity: newMovie, insertInto: managedContext)
            newMovie.title = movie.title
            newMovie.originalTitle = movie.originalTitle
            newMovie.backdropPath = movie.backdropPath
            newMovie.originalLanguage = movie.originalLanguage
            newMovie.releaseDate = movie.releaseDate
            newMovie.overview = movie.overview
            newMovie.popularity = movie.popularity
            newMovie.posterPath = movie.posterPath
            newMovie.voteAverage = movie.voteAverage
            newMovie.movieId = Int64(movie.movieId)
            newMovie.moviesType = moviesType.method
            newMovie.id = UUID()
            do {
                try managedContext.save()
            } catch let error as NSError {
                errorCoreDataAlert?(error.localizedDescription)
            }
        }
    }

    func getData(moviesType: MethodType) -> [MovieData] {
        var movieObjects: [MovieData] = []
        let fetchRequest: NSFetchRequest<MovieData> = MovieData.fetchRequest()
        let predicate = NSPredicate(format: Constants.predicateFormat, moviesType.method)
        fetchRequest.predicate = predicate
        do {
            movieObjects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            errorCoreDataAlert?(error.localizedDescription)
        }
        return movieObjects
    }
}
