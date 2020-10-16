//
//  error.swift
//  Project1
//
//  Created by vn00082 on 10/16/20.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import Foundation
enum WeSpliterror: Error, Equatable {
    case responseModelParsingError
    case invalidRequestURLStringError
    case requestURLFail(description: String)
}
