//
//  Extensions+Thread.swift
//  SurfingSpots
//
//  Created by Gabriele Diletto on 13/12/21.
//

import Foundation

// This extension checks if the unit tests are running in the current thread
extension Thread {
    var isRunningXCTest: Bool {
        if ProcessInfo().environment["APP_IS_TEST"] == "TRUE" {
            return true
        }
        for key in threadDictionary.allKeys {
            guard let keyAsString = key as? String else {
                continue
            }

            if keyAsString.split(separator: ".").contains("xctest") {
                return true
            }
        }
        return false
    }
}
