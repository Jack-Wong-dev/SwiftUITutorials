import SwiftUI

struct TweetBot: View {
    var body: some View {
        
        let cornerRadius: CGFloat = 7.5
        
        return HStack(alignment: .top) {
            VStack {
                Image("RW")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .cornerRadius(cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.white, lineWidth: 2.5)
                )
                
                Text("Following")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .clipShape( Capsule() )
            }
            
            VStack(alignment: .leading) {
                
                Text("raywenderlich.com")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack(alignment: .lastTextBaseline) {
                    Text("@rwenderlich")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Text("FOLLOWS YOU")
                        .font(.caption)
                        .foregroundColor( .init(white: 04) )
                        .padding(.horizontal, 10)
                        .background( Color(white: 0.9))
                        .clipShape( Capsule() )
                    
                }
                
                Text(
                    "We are a friendly and supportive community of mobile developers. "
                        + "We love to learn and share our knowledge with the world! "
                        + "raywenderlich.com"
                )
                    .padding(.top, 5)
                    .lineSpacing(-.infinity)
            }
        }
        
    }
}

struct TweetBot_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 0.55, green: 0.45, blue: 0.75)
            TweetBot()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

