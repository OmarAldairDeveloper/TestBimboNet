//
//  Mission.swift
//  PruebaTecnicaBimbo
//
//  Created by Omar Aldair on 29/05/23.
//

import Foundation

struct Mission: Codable {
    let name: String
    let year: String
    let missionNumber: Int
    let details: String?
    let launchSite: LauchSite?
    let links: Links?
    let rocket: Rocket?
    enum CodingKeys: String, CodingKey {
        case name = "mission_name"
        case year = "launch_year"
        case missionNumber = "flight_number"
        case details = "details"
        case launchSite = "launch_site"
        case links = "links"
        case rocket = "rocket"
    }
}

struct Links: Codable {
    let imageURL: String?
    let videoURL: String?
    let images: [String]?
    let articleURL: String?
    enum CodingKeys: String, CodingKey {
        case imageURL = "mission_patch"
        case videoURL = "video_link"
        case images = "flickr_images"
        case articleURL = "article_link"
    }
}

struct LauchSite: Codable {
    let siteName: String?
    enum CodingKeys: String, CodingKey {
        case siteName = "site_name"
    }
}

struct Rocket: Codable {
    let rocketName: String?
    let rocketType: String?
    enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}

