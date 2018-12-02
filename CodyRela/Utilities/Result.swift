//
//  Result.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import Foundation

enum Result<T> {
    case value(T)
    case error(Error)
}
