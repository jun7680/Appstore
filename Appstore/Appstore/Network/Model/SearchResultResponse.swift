//
//  SearchResultResponse.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import Foundation

struct SearchResultResponse: Codable {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let screenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let advisories: [String]
    let trackCensoredName: String
    let languageCodesISO2A: [String]
    let contentAdvisoryRating: String
    let averageUserRating: Double
    let releaseNotes: String?
    let currentVersionReleaseDate: String
    let trackName: String
    let releaseDate: String
    let primaryGenreName: String
    let sellerName: String
    let genres: [String]
    let version: String
    let userRatingCount: Int
}
