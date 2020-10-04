//
//  CarouselSlider.swift
//  Kavsoft
//
//  Created by Jack Wong on 9/4/20.
//

import SwiftUI

struct CarouselSlider: View {
    
    @State var books = [
        
        // Make Sure id is in ascending Order....
        
        Book(id: 0, image: "carousel1", title: "The Murder of Roger Ackroyd", author: "Agatha Christie", rating: 3, offset: 0),
        Book(id: 1, image: "carousel0", title: "The Hound of the Baskervilles", author: "Arthur Conan", rating: 4, offset: 0),
        Book(id: 2, image: "carousel3", title: "The Girl with the Dragon Tattoo", author: "Stieg Larsson", rating: 4, offset: 0),
        Book(id: 3, image: "carousel2", title: "The Godfather", author: "Mario Puzo", rating: 5, offset: 0),
        Book(id: 4, image: "carousel5", title: "The Lovely Bones", author: "Alice Sebold", rating: 4, offset: 0),
        Book(id: 5, image: "carousel4", title: "Rebecca", author: "Daphne Du Maurier", rating: 4, offset: 0),
    ]
    
    @State var swiped = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Custom Carousel")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    Image(systemName: "circle.grid.2x2.fill")
                        .font(.system(size: 22))
                }
            }
            .foregroundColor(.white)
            .padding()
            
            Spacer(minLength: 0)
            
            ZStack {
                //Reverse the array because we're books overlay one another
                ForEach(books.reversed()) { book in
                    GeometryReader { geo in
                        HStack {
                            ZStack {
                                Image(book.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geo.size.width - 100, height: getHeight(height: geo.size.height / 2, index: book.id))
                                    .cornerRadius(25)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5)
                                
                                //Read more button
                                CardView(card: book)
                            }
                            
                            Spacer(minLength: 0)
                        }
                        .contentShape(Rectangle())
                        .padding(.horizontal)
                        .offset(x: book.id < 3 ? CGFloat(book.id) * 30 : 60)
                        .offset(x: book.offset)
                        .gesture(
                            DragGesture().onChanged({ (value) in
                                withAnimation() {
                                    onScroll(width: geo.size.width - 100, value: value.translation.width, index: book.id
                                    )
                                }
                            })
                            .onEnded({ (value) in
                                withAnimation() {
                                    onEnd(width: geo.size.width - 100, value: value.translation.width, index: book.id)
                                }
                            })
                        )
                    }
                }
                
            }
            
        }
        .background(Color("bg")).ignoresSafeArea(.all)
    }
    
    func getHeight(height: CGFloat, index : Int)->CGFloat{
        
        // two card = 80
        // all other are 80 at background....
        
        // automatic height and offset adjusting...
        
        return height - (index - swiped < 3 ? CGFloat(index - swiped) * 40 : 80)
    }
    
    func onScroll(width: CGFloat, value: CGFloat,index: Int){
        
        if value < 0{
            
            // Left Swipe...
            
            if index != books.last!.id{
                
                books[index].offset = value
            }
        }
        else{
            
            // Right Swipe....
            
            // Safe Check...
            if index > 0{
                
                books[index - 1].offset = -(width + 60) + value
            }
        }
    }
    
    func onEnd(width: CGFloat, value: CGFloat,index: Int){
        
        if value < 0{
            
            if -value > width / 2 && index != books.last!.id{
                
                books[index].offset = -(width + 60)
                swiped += 1
            }
            else{
                
                books[index].offset = 0
            }
        }
        else{
            
            if index > 0{
                
                if value > width / 2{
                    
                    books[index - 1].offset = 0
                    swiped -= 1
                }
                else{
                    
                    books[index - 1].offset = -(width + 60)
                }
            }
        }
    }
}



struct CarouselSlider_Previews: PreviewProvider {
    static var previews: some View {
        CarouselSlider()
    }
}


// Carousel Model Book Data...

struct Book : Identifiable {
    
    var id: Int
    var image : String
    var title : String
    var author : String
    var rating : Int
    var offset : CGFloat
}

struct CardView : View {
    
    var card : Book
    
    var body: some View{
        
        VStack{
            
            // You can display all details
            // I'm displaying only read button....
            Spacer(minLength: 0)
            
            HStack{
                
                Button(action: {}) {
                    
                    Text("Read Now")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(Color("purple"))
                        .clipShape(Capsule())
                }
                
                Spacer(minLength: 0)
            }
            .padding()
        }
        
    }
}
