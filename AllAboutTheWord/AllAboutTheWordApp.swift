//
//  AllAboutTheWordApp.swift
//  AllAboutTheWord
//
//  Created by Nineleaps on 03/11/21.
//

import SwiftUI

@main
struct AllAboutTheWordApp: App {
    var apiRequest = APIRequest()
    var body: some Scene {
        WindowGroup {
            ContentView(searchText: "").environmentObject(apiRequest)
        }
    }
}
