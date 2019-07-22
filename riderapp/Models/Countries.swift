//
//  Countries.swift
//  riderapp
//
//  Created by Gregory Jones on 7/17/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import Foundation


struct Countries: Decodable {
    let countries: [Country]
}

extension Countries {
    var sections: [String] {
        return Array(metaData.keys).sorted(by: <)
    }
    var metaData: [String: [Country]] {
        return Dictionary(grouping: countries, by:{String($0.name.first!)})
    }
}
