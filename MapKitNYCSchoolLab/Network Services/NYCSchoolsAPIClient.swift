//
//  NYCSchoolsApiClient.swift
//  MapKitNYCSchoolLab
//
//  Created by David Lin on 2/22/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation
import NetworkHelper

struct NYCSchoolsAPIClient {
    static func findHighSchool(completion: @escaping(Result < [AllSchools], AppError >) -> ()) {
      let endpointURLString = "https://data.cityofnewyork.us/resource/uq7m-95z8.json"
        
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case.failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let schools = try JSONDecoder().decode([AllSchools].self, from: data)
                    completion(.success(schools))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        
    }
    
}
