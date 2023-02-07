// ResultsMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Фильмы
struct ResultsMovie: Decodable {
    /// Фильмы
    let movies: [Movie]

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
