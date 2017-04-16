//
//  main.swift
//  RevengeOfThePancakes
//
//  Created by gurren-l on 2017. 4. 15..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import Foundation

print("Hello, World!")

let filePath = Bundle.main.path(forResource: "RevengeOfThePancakes/B-small-practice", ofType: "in")
print("file path: \(filePath ?? "")")

Bundle.main.path(forResource: "B-small-practice", ofType: "in")
