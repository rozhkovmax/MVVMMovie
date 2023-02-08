// FileService.swift
// Copyright © Rozhkov M.N. All rights reserved.

import Foundation

/// Файл менеджер
final class FileService: FileServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let cacheLifeTime = 30.0 * 24.0 * 60.0 * 60.0
        static let imagePathName = "images"
        static let separator: Character = "/"
        static let defaultFileName: Substring = "default"
    }

    // MARK: - Private Properties

    private let cacheLifeTime: TimeInterval = Constants.cacheLifeTime
    private static let pathName: String = {
        let pathName = Constants.imagePathName
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()

    // MARK: - Public Methods

    func saveImageToCache(url: String, data: Data) {
        guard let fileName = getFilePath(url: url)
        else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }

    func getImageFromCache(url: String) -> Data? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        let fileUrl = URL(filePath: fileName)
        guard lifeTime <= cacheLifeTime else { return nil }
        let data = try? Data(contentsOf: fileUrl)
        return data
    }

    // MARK: - Private Methods

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        let hashName = url.split(separator: Constants.separator).last ?? Constants.defaultFileName
        return cachesDirectory
            .appendingPathComponent(FileService.pathName + String(Constants.separator) + hashName)
            .path
    }
}
