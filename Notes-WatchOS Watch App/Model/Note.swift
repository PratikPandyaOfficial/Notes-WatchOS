//
//  Note.swift
//  Notes-WatchOS Watch App
//
//  Created by Drashti on 20/12/23.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
