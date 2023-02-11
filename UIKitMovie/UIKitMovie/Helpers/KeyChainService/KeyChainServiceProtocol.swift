// KeyChainServiceProtocol.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Протокол сервиса хранения критических данных пользователя
protocol KeyChainServiceProtocol {
    func getAPIKey(_ key: String) -> String
    func saveAPIKey(_ value: String, forKey: String)
}
