//
//  service.swift
//  art_words_v1.0
//
//  Created by My iMac on 19/1/2025.
//

import Common

public protocol NetworkService {
    func fetchData(from endpoint: String) -> [String]
}

public class NetworkServiceImpl: NetworkService {	
    public init() {}

    public func fetchData(from endpoint: String) -> [String] {
        // Simulated API call
        return ["Item1", "Item2"]
    }
}
