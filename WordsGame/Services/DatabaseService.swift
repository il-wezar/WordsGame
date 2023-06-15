//
//  DatabaseService.swift
//  WordsGame
//
//  Created by Illia Wezarino on 14.06.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()
    private let db = Firestore.firestore()
    
    private var wordsRef: CollectionReference {
        return db.collection("words")
    }
    
    private init() { }
    
    func getWord(completion: @escaping (Result<WordModel, Error>) -> Void) {
        wordsRef.getDocuments { docSnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let randomDocument = docSnapshot!.documents.randomElement() else { return }
                guard let word = randomDocument.data()["word"] as? String else { return }

                let bigWord = WordModel(word: word)

                completion(.success(bigWord))
            }
        }
    }
}
