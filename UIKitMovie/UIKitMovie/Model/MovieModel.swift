// MovieModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель выбора фильмов из АПИ
struct ResultsMovie: Decodable {
    let movies: [Movie]
}

/// Модель фильмов
struct Movie: Decodable {
    let id: Int
    let posterPath: String?
    let title: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let popularity: Double
    let originalTitle: String
    let originalLanguage: String
    let backdropPath: String
}
