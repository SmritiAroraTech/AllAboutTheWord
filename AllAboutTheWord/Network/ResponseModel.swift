//
//  ResponseModel.swift
//  AllAboutTheWord
//
//  Created by Nineleaps on 03/11/21.
//

import Foundation

struct WordDetails: Codable {
    
    var word: String
    var phonetic: String?
    var phonetics: [Phonetics]
    var origin: String?
    var meanings: [Meanings]
    
    struct Phonetics: Codable {
        var text: String?
        var audio: String?
    }
    
    struct Meanings: Codable {
        var partOfSpeech: String
        var definitions: [Definitions]
    }
    
    struct Definitions: Codable {
        var definition: String
        var example: String?
        var synonyms: [String?]
        var antonyms: [String?]
    }
}
