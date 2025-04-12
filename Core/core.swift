//
//  core.swift
//  art_words_v1.0
//
//  Created by My iMac on 19/1/2025.
//

import Repository
//import Service

public protocol FetchDataUseCase {
    func fetchData() -> [String]
}
