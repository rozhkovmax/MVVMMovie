// MovieData+CoreDataProperties.swift
// Copyright © Rozhkov M.N. All rights reserved.

import CoreData
import Foundation

/// Информация о фильме
extension MovieData: Identifiable {
    private enum Constants {
        static let coreDataModelName = "MovieData"
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        NSFetchRequest<MovieData>(entityName: Constants.coreDataModelName)
    }

    /// Фон
    @NSManaged public var backdropPath: String?
    /// Уникальный идентификатор
    @NSManaged public var id: UUID?
    /// Идентификатор фильма
    @NSManaged public var movieId: Int64
    /// Тип запроса
    @NSManaged public var moviesType: String?
    /// Язык оригинала
    @NSManaged public var originalLanguage: String?
    /// Оригинальное название
    @NSManaged public var originalTitle: String?
    /// Описание
    @NSManaged public var overview: String?
    /// Популярность
    @NSManaged public var popularity: Double
    /// Постер
    @NSManaged public var posterPath: String?
    /// Дата выхода в прокат
    @NSManaged public var releaseDate: String?
    /// Название
    @NSManaged public var title: String?
    /// Рейтинг
    @NSManaged public var voteAverage: Double
}
