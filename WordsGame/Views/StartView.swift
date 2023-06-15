//
//  ContentView.swift
//  WordsGame
//
//  Created by Illia Wezarino on 11.06.2023.
//

import SwiftUI

struct StartView: View {
    @State private var bigWord = ""
    @State private var firstPlayer = ""
    @State private var secondPlayer = ""
    
    @State private var isShowedGame = false
    @State private var isAlertPresent = false
    @StateObject var viewModel: StartViewModel
    
    var body: some View {
        VStack {
            Spacer()
            TitleText(text: "Words Game")
            WordsTextField(word: $bigWord, placeHolder: "Enter long word")
                .padding(20)
                .padding(.vertical, -4)
            
            HStack() {
                Spacer()
                Button {
                    DispatchQueue.main.async {
                        viewModel.getRandomWord()

                        bigWord = viewModel.wordModel.word
                    }
                } label: {
                    Text("Random word")
                        .padding()
                        .padding(.vertical, -8)
                        .padding(.bottom, 16)
                        .foregroundColor(Color("dark"))
                        .shadow(color: .gray, radius: 2)
                }
            }
            .frame(maxWidth: .infinity)


            WordsTextField(word: $firstPlayer, placeHolder: "First player")
                .padding(.horizontal, 20)
                .padding(.top, 15)

            WordsTextField(word: $secondPlayer, placeHolder: "Second player")
                .padding(.horizontal,20)

            Button {
                if bigWord.count > 6 {
                    isShowedGame.toggle()
                } else {
                    isAlertPresent.toggle()
                }
            } label: {
                Text("Start")
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .foregroundColor(.white)
                    .padding(12)
                    .padding(.horizontal, 48)
                    .background(Color("dark").opacity(0.9))
                    .cornerRadius(16)
                    .padding(.top)
            }
            Spacer()
        }
        .background(Image("bgMain")
            .resizable()
            .frame(maxWidth: .infinity)
            .ignoresSafeArea()
            .scaledToFill())
        .alert("The word is too short!", isPresented: $isAlertPresent, actions: { })
        .fullScreenCover(isPresented: $isShowedGame) {
            let firstName = firstPlayer == "" ? "First Player" : firstPlayer
            let secondName = secondPlayer == "" ? "Second Player" : secondPlayer
            
            let firstPlayer = PlayerModel(name: firstName)
            let secodPlayer = PlayerModel(name: secondName)
            let gameViewModel = GameViewModel(firstPlayer: firstPlayer,
                                              secondPlayer: secodPlayer,
                                              word: bigWord)
            
            GameView(viewModel: gameViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(viewModel: StartViewModel(word: WordModel(word: "")))
    }
}
