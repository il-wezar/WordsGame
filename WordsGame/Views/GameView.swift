//
//  GameView.swift
//  WordsGame
//
//  Created by Illia Wezarino on 11.06.2023.
//

import SwiftUI

struct GameView: View {
    @Environment (\.dismiss) var dismiss
    @State private var word = ""
    @State private var confirmPresent = false
    @State private var isAlertPresent = false
    @State private var alertText = ""
    
    var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    confirmPresent.toggle()
                } label: {
                    Text("Quit")
                        .padding(8)
                        .padding(.horizontal, 24)
                        .background(Color("dark").opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.custom("AvenirNext-Bold", size: 18))
                }
                Spacer()
            }.padding()
            
            Text(viewModel.word)
                .font(.custom("AvenirNext-Bold", size: 32))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .foregroundColor(Color("dark"))
            
            HStack(spacing: 12) {
                VStack {
                    Text("\(viewModel.firstPlayer.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text(viewModel.firstPlayer.name)
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                }
                .padding(20)
                .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                .background(Color("lightGray"))
                .cornerRadius(26)
                .shadow(color: viewModel.isFirst ? .gray : .clear, radius: 4)
                
                VStack {
                    Text("\(viewModel.secondPlayer.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text(viewModel.secondPlayer.name)
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                }
                .padding(20)
                .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                .background(Color("lightBlue"))
                .cornerRadius(26)
                .shadow(color: viewModel.isFirst ? .clear : .cyan, radius: 4)
            }
            
            WordsTextField(word: $word, placeHolder: "Eneter word")
                .padding(.horizontal)
            
            Button {
                var score = 0
                
                do {
                    try score = viewModel.cheak(word: self.word)
                } catch WordError.beforeWord {
                    alertText = "This word also been used"
                    isAlertPresent.toggle()
                } catch WordError.littleWord {
                    alertText = "This word is too short"
                    isAlertPresent.toggle()
                } catch WordError.theSameWord {
                    alertText = "This word is unavilable"
                    isAlertPresent.toggle()
                } catch WordError.wrongWord {
                    alertText = "This word cannot be used"
                    isAlertPresent.toggle()
                } catch {
                    alertText = "Undefind error"
                    isAlertPresent.toggle()
                }
                
                if score > 1 {
                    self.word = ""
                }
                
                print("ready")
                
            } label: {
                Text("Ready")
                    .padding(12)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color("dark").opacity(0.9))
                    .font(.custom("AvenirNext-Bold", size: 26))
                    .cornerRadius(16)
                    .padding(.horizontal)
            }
      
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(0..<viewModel.words.count, id: \.description) { item in
                        WordCell(word: self.viewModel.words[item].lowercased())
                            .listRowInsets(EdgeInsets())
                            .background(item % 2 == 0 ? Color("lightGray").opacity(0.8) : Color("lightBlue").opacity(0.8))
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .background(Image("bgMain")
            .resizable()
            .frame(maxWidth: .infinity)
            .ignoresSafeArea()
            .scaledToFill())
        .confirmationDialog("Are you sure you want to quit the game?", isPresented: $confirmPresent, titleVisibility: .visible) {
            Button(role: .destructive) {
                self.dismiss()
            } label: {
                Text("Quit")
            }
        }
        .alert(alertText, isPresented: $isAlertPresent, actions: { })
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(firstPlayer: PlayerModel(name: "Vasya"), secondPlayer: PlayerModel(name: "Fedya"), word: "Рекогнoсцировка"))
    }
}
