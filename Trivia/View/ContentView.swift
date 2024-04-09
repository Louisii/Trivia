//
//  ContentView.swift
//  Trivia
//
//  Created by Louisi Dalazen on 05/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var questaoVM = QuestaoVM()
    
    @State var showCorrect : Bool = false
    @State var userChoice : String?
    @State var isUserRight : Bool?
    
    var body: some View {
        
        
        ZStack {
            if(isUserRight != nil){
                if(isUserRight!){
                    Rectangle().fill( LinearGradient(gradient: Gradient(colors: [.green.opacity(0.6), .green.opacity(0.1)]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
                }else{
                    Rectangle().fill( LinearGradient(gradient: Gradient(colors: [.red.opacity(0.6), .red.opacity(0.1)]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
                }
            }else{
                Rectangle().fill( LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.4), .blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea()
            }
            
            VStack() {
                
                if(questaoVM.result != nil){
                    let questao : Questao = questaoVM.result!;
                    
                    //                let questoes : [String?] = questaoVM.getAllAnswers()
                    let questoes : [String?] = questao.all_answers ?? []
                    
                    
                    HStack {
                       
                        VStack {
                            Image(systemName: "doc.questionmark.fill").font(.system(size: 60)).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Text("Trivia").font(.title.bold()).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }.padding().background(.white).cornerRadius(10).padding(.bottom)
                        VStack(alignment: .leading){
                            Text(questao.difficulty ?? "").font(.headline)
                            Text(questao.category ?? "").font(.headline)
                        }
                       
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    VStack(alignment: .leading) {
                        Text( "\(questaoVM.decodeHtmlString(string: questao.question ?? ""))").font(.title).padding(.vertical)
                        ForEach(questoes, id: \.self){ a in
                            HStack{
                                Spacer()
                                Text(a!)
                                if(showCorrect){
                                    if( a! == questao.correct_answer){
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                    }else  if(a! == userChoice && a! != questao.correct_answer){
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.red)
                                    }
                                }
                                Spacer()
                            }.padding(10).onTapGesture {
                                userChoice = a!
                                showCorrect = true
                                isUserRight = userChoice == questao.correct_answer!
                            }
                        }
                    }.padding().background(.white).cornerRadius(10).padding()
                    
                    
                    
                    HStack {
                        Spacer()
                        Image(systemName: "arrowshape.forward.fill").font(.system(size: 30))
                            .onTapGesture(perform: {
                                questaoVM.fetch()
                                showCorrect = false
                                isUserRight = nil
                                userChoice = nil
                            })
                    }
                    
                    
                    
                    
                }else{
                    Image(systemName: "arrow.clockwise.circle.fill").font(.system(size: 60)).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .onTapGesture(perform: {
                            questaoVM.fetch()
                            showCorrect = false
                            isUserRight = nil
                            userChoice = nil
                        })
                }
                
            }
            .padding()
            .onAppear(){
                questaoVM.fetch()
            }
        }
    }
}



#Preview {
    ContentView()
}
