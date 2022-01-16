//
//  Bundle+Extension.swift
//  WeatherApp
//
//  Created by Rami Ounifi on 15/1/2022.
//

import SwiftUI

extension Bundle {
    static func valueForAPIKey(named keyname:String) -> String {
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")
      let plist = NSDictionary(contentsOfFile:filePath!)
      let value = plist?.object(forKey: keyname) as! String
      return value
    }
}
