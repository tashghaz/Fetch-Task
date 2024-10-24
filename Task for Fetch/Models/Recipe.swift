//
//  Recipe.swift
//  Task for Fetch
//
//  Created by Artashes Ghazaryan on 10/8/24.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    let id: String  // We will use the "uuid" from the JSON as the unique identifier
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let cuisine: String?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"  // Map "uuid" from JSON to "id"
        case name
        case photoUrlLarge = "photo_url_large"  // Map "photo_url_large" to "photoUrlLarge"
        case photoUrlSmall = "photo_url_small"  // Map "photo_url_small" to "photoUrlSmall"
        case sourceUrl = "source_url"           // Map "source_url" to "sourceUrl"
        case cuisine
    }
}
