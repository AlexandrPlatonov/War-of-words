

import SwiftUI

struct GameView: View {
    @State private var word = ""
    var viewModel: GameViewModel
    @State private var confirPresent = false
    @State private var isAlertPresent = false
    @State var alertText = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                Button {
                    confirPresent.toggle()
                } label: {
                    Text ("Выход")
                        .padding(6)
                        .padding(.horizontal)
                        .background(Color("Orange"))
                        .cornerRadius(12)
                        .padding(6)
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Bold", size: 18))
                }
                Spacer()
            }
            
            Text(viewModel.word)
                .font(.custom("AvenirNext-Bold", size: 30))
                .foregroundColor(.white)
            
            HStack(spacing: 12) {
                VStack {
                    Text("\(viewModel.player1.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player1.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                } .padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ? .purple : .clear, radius: 4, x: 0, y: 0)
            
        
            
            VStack {
                Text("\(viewModel.player2.score)")
                    .font(.custom("AvenirNext-Bold", size: 60))
                    .foregroundColor(.white)
                Text("\(viewModel.player2.name)")
                    .font(.custom("AvenirNext-Bold", size: 24))
                    .foregroundColor(.white)
            } .padding(20)
                .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                .background(Color("secondColor"))
                .cornerRadius(26)
                .shadow(color: viewModel.isFirst ? .clear : .purple, radius: 4, x: 0, y: 0)
        
    }
            WordsTextFields(word: $word, placeholder: "Ваше слово..")
                .padding(.horizontal)
            
            Button {
                var score = 0
                do {
                    try score = viewModel.check(word: word)
                } catch WordError.beforeWord {
                alertText = "Такое слово уже было"
                    isAlertPresent.toggle()
                } catch WordError.littleWord {
                    alertText = "Придумай слово в котором больше 2 букв"
                        isAlertPresent.toggle()
                } catch WordError.theSameWord {
                    alertText = "Ха-ха исходное слово решил использовать.. Придумай свое!"
                        isAlertPresent.toggle()
                } catch WordError.wrongWord {
                    alertText = "Такое слово не может быть составлено!"
                        isAlertPresent.toggle()
                } catch {
                    alertText = "Неизвестная ошибка"
                    isAlertPresent.toggle()
                }
                if score > 1 {
                    self.word = ""
                }
            } label : {
                Text ("Готово")
                    .padding(12)
                    .foregroundColor(.white)
                    .background(Color("Orange"))
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    .font(.custom("AvenirNext-Bold", size: 26))
                    .padding(.horizontal)
            }
            List {
                ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color("FirstPlayer") : Color("secondColor"))
                        .listRowInsets(EdgeInsets())
                }
            } .listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.background(Image("background"))
            .confirmationDialog("Вы уверены, что хотите завершить игру?", isPresented: $confirPresent, titleVisibility: .visible) {
                Button(role: .destructive) {
                    self.dismiss()
                } label : {
                    Text("Да")
                }
                Button(role: .cancel) {
                } label : {
                    Text("Нет")
                }
            }
            .alert(alertText, isPresented: $isAlertPresent, actions: {
                Text("Ок, понял..")
            })
    }
    
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Вася"), player2: Player(name: "Петя"), word: "Реконструкция"))
    }
}
