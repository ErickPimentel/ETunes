//
//  FetchState.swift
//  ETunes
//
//  Created by Erick Spinelli Pimentel on 12/18/22.
//

import Foundation

enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case error(String)
}
