// Movie.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Фильм
struct Movie: Decodable {
    /// Идентификатор
    let movieId: Int
    /// Постер
    let posterPath: String?
    /// Название
    let title: String
    /// Описание
    let overview: String
    /// Рейтинг
    let voteAverage: Double
    /// Дата выхода в прокат
    let releaseDate: String
    /// Популярность
    let popularity: Double
    /// Оригинальное название
    let originalTitle: String
    /// Язык оригинала
    let originalLanguage: String
    /// Фон
    let backdropPath: String?

    private enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case posterPath = "poster_path"
        case title
        case overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case popularity
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
    }
}
