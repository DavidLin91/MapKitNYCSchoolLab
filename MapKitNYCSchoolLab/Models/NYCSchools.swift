//
//  NYCSchools.swift
//  MapKitNYCSchoolLab
//
//  Created by David Lin on 2/22/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation

struct NYCPublicSchool: Codable {
    let schools: [AllSchools]
}

struct AllSchools: Codable {
    let school_name: String
    let neighborhood: String
    let phone_number: String
    let school_email: String
    let city: String
    let zip: String
    let state_code: String
    let borough: String
    let latitude: String
    let longitude: String
}
