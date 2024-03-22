//
//  TiktacToeApp.swift
//  TiktacToe
//
//  Created by PRACHIKA AGARWAL on 21/03/24.
//

import SwiftUI

@main
struct TiktacToeApp: App {
    @StateObject var game = GameService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
        }
    }
}
