

import SwiftUI

struct WordsTextFields: View {
    
    @State var word: Binding<String>
    var placeholder: String
    
    var body: some View {
            TextField(placeholder, text: word)
            .font(.title2)
            .padding()
            .background(.white)
            .cornerRadius(12)
    }
}
