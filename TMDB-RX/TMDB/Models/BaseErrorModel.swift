//
//  BaseErrorModel.swift
//  TMDB
//
//  Created by Dina Reda on 3/19/21.
//

import Foundation

struct BaseErrorModel: Codable {
    let status_message: String?
    let success: Bool?
    let status_code: Int?
}
