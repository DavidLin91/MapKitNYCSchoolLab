//
//  NYCSchools.swift
//  MapKitNYCSchoolLab
//
//  Created by David Lin on 2/22/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation
import MapKit

struct AllSchools: Codable {
    let schoolName: String
    let neighborhood: String
    let phoneNumber: String
    let schoolEmail: String
    let city: String
    let zip: String
    let stateCode: String
    let borough: String
    let latitude: String
    let longitude: String
    
    private enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case neighborhood
        case phoneNumber = "phone_number"
        case schoolEmail = "school_email"
        case city
        case zip
        case stateCode = "state_code"
        case borough
        case latitude
        case longitude
    }
    
}
