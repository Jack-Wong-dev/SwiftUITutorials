import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) {
                card in
                CardView(card: card)
                    .onTapGesture {
                        withAnimation(.linear(duration: 2)) {
                            self.viewModel.choose(card: card)
                        }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(.orange)
            
            Button(action: {
                withAnimation(.easeOut) {
                    self.viewModel.resetGame()
                }
            }) { Text("New Game") }
        }
        
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90),clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1))
            }
                .cardify(isFaceUp: card.isFaceUp) //Custom View Modifier
        }
    }
    
    //MARK: -- Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        
        return EmojiMemoryGameView(viewModel: game)
    }
}
