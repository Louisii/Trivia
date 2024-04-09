//
//  QuestaoVM.swift
//  Trivia
//
//  Created by Louisi Dalazen on 05/04/24.
//

import Foundation

class QuestaoVM : ObservableObject {
    @Published var result : Questao?
    
    func fetch(){
        guard let url = URL(string: "https://opentdb.com/api.php?amount=1&type=multiple" ) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
              
                    let parsed = try JSONDecoder().decode(Result.self, from: data)
                    DispatchQueue.main.async {
                        self?.result = parsed.results?.first
                        self?.result?.all_answers = self?.getAllAnswers()
                    }
                
                
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
    func getAllAnswers() -> [String?] {
        var all : [String] = []
        
        if(result!.incorrect_answers != nil){
            all = result!.incorrect_answers!
        }
        if(result!.correct_answer != nil){
            all.append(result!.correct_answer!)
        }
        
        if(!all.isEmpty){
            all.shuffle()
        }
        
        return all
    }
    
    func decodeHtmlString(string: String) -> String{
            guard let data = string.data(using: .utf8) else {
                return ""
            }

            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]

            guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
                return ""
            }

            return (attributedString.string)
        }
}
