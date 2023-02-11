// ImageServiceProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import UIKit

/// Протокол сервиса запроса изображения
protocol ImageServiceProtocol {
    func getImage(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
