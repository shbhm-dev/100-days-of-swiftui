//
//  Person.swift
//  Milestone-Projects13-15
//
//  Created by clarknt on 2019-12-17.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct Person: Codable, Identifiable {
    var id = UUID()
    var name: String
    var imagePath: String?

    /// image is image data in any format
    mutating func setImage(image: Data) {
        let url = getDocumentDirectory().appendingPathComponent(UUID().uuidString)

        do {
            try image.write(to: url, options: [.atomicWrite, .completeFileProtection])
            self.imagePath = url.lastPathComponent
        }
        catch let error {
            print("Could not write image: " + error.localizedDescription)
        }
    }

    func getImage() -> Data? {
        guard let imagePath = imagePath else { return nil }

        // a cache system might be useful here, instead of loading every time from disk
        let url = getDocumentDirectory().appendingPathComponent(imagePath)
        if let data = try? Data(contentsOf: url) {
            return data
        }

        return nil
    }

    mutating func deleteImage() {
        guard let imagePath = imagePath else { return }

        do {
            let url = getDocumentDirectory().appendingPathComponent(imagePath)
            try FileManager.default.removeItem(at: url)
        }
        catch let error {
            print("Could not delete image: \(error.localizedDescription)")
        }

        self.imagePath = nil
    }

    private func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
