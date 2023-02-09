// MovieData+CoreDataProperties.swift
// Copyright © Rozhkov M.N. All rights reserved.

import CoreData
import Foundation

/// Расширение базы данных
extension MovieData: Identifiable {
    private enum Constants {
        static let coreDataModelName = "MovieData"
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        NSFetchRequest<MovieData>(entityName: Constants.coreDataModelName)
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var id: UUID?
    @NSManaged public var movieId: Int64
    @NSManaged public var moviesType: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double
}
