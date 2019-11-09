//
//  DogImageData.swift
//  Dogs
//
//  Created by Ahmed Sultan on 11/9/19.
//  Copyright © 2019 Ahmed Sultan. All rights reserved.
//

import Foundation
struct DogImage : Codable {
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
