//
//  ContentView.swift
//  AllAboutTheWord
//
//  Created by Nineleaps on 03/11/21.
//

import SwiftUI

struct ContentView: View {
    @State var searchText: String
    @State var isEditing = false
    @State var isSearched = false
    @State var searchHistory = [String]()
    @EnvironmentObject var apiRequest: APIRequest
    var body: some View {
        NavigationView{
            VStack(alignment: HorizontalAlignment.leading){
                Text("All About The word")
                    .fontWeight(Font.Weight.bold)
                    .padding(.leading).font(.system(size: 35))
                HStack {
                    HStack {
                        TextField("Type in your word", text: $searchText)
                            .padding(7)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                self.isEditing = true
                            }
                        
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.searchText = ""
                                
                            }) {
                                Text("Cancel")
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.default)
                        }
                    }
                    Button("Search") {
                        apiRequest.getWordData(forWord: searchText) { result in
                            if !result.isEmpty {
                                isSearched = true
                                if searchHistory.count >= 5 {
                                    searchHistory.removeFirst()
                                }
                                searchHistory.append(apiRequest.wordData[0].word)
                            }
                        }
                    }
                    .padding(.trailing)}
                
                if isSearched == true {
                    if !apiRequest.wordData.isEmpty {
                        
                        let word = apiRequest.wordData[0]
                        VStack(alignment: .leading) {
                            Text("Origin: \(word.origin ?? "")")
                            Spacer()
                            Text("meaning: \(word.meanings[0].definitions[0].definition)")
                            Spacer()
                            if !word.phonetic!.isEmpty {Text("Phonetic: \(word.phonetic ?? "")")}
                            Spacer()
                            Text("Part of speech: \(word.meanings[0].partOfSpeech)")
                            Spacer()
                            if let synonymsArray = word.meanings[0].definitions[0].synonyms {
                                if !synonymsArray.isEmpty {
                                    Text("Synonyms: \(synonymsArray[0] ?? ""), \(synonymsArray[1] ?? "")")
                                    Spacer()
                                }
                                
                                if let antonymsArray = word.meanings[0].definitions[0].antonyms {
                                    if !antonymsArray.isEmpty {
                                        Text("Antonyms: \(antonymsArray[0] ?? "")")
                                    }
                                }
                            }
                            
                        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    }
                }
                
                List {
                    Section(header:
                                Text("Search History")) {
                        ForEach(searchHistory, id: \.self) { word in
                            Text(word)
                        }
                    }
                }
                
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(searchText: "").environmentObject(APIRequest())
    }
}

