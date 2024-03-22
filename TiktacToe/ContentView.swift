//
//  ContentView.swift
//  TiktacToe
//
//  Created by PRACHIKA AGARWAL on 21/03/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game:GameService
    @State private var gameType: GameType = .undetermined
    @State private var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus: Bool
    @State private var startGame = false
    var body: some View {
        VStack {
            Picker("Select Gamee", selection: $gameType){
                Text("Select Game Type").tag(GameType.undetermined)
                Text("Two Sharing Device").tag(GameType.single)
                Text("Cllange your Device").tag(GameType.bot)
                Text("Challenge a friend").tag(GameType.peer)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 2.0))
            Text(gameType.description)
                .padding()
            VStack{
                switch gameType {
                case .single:
                    VStack{
                        TextField("Your Name", text:$yourName)
                        TextField("Opponent Name", text:$opponentName)
                    }
                case .bot:
                    TextField("Your Name", text:$yourName)
                case .peer:
                    EmptyView()
                case .undetermined:
                    EmptyView()
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus)
            .frame(width: 350)
            if gameType != .peer{
                Button("Start Game"){
                    game.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                    focus=false
                    startGame.toggle()
                }
                .buttonStyle(.borderedProminent)
                .disabled(
                    gameType == .undetermined ||
                    gameType == .bot && yourName.isEmpty ||
                    gameType == .single &&
                    (yourName.isEmpty ||
                     opponentName.isEmpty)
                )
                Image("LaunchScreen")
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Xs and Os")
        .fullScreenCover(isPresented: $startGame) {
            GameView()
        }
        .inNavigationStack()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
            .environmentObject(GameService())
    }
}
