//
//  FlipView.swift
//  CRUD
//
//  Created by David on 16/6/21.
//

import Foundation
import SwiftUI

struct Flip : View {
    
    @State var showBack = false
    
    var body : some View {
        
        let front = FrontView()
        let back = BackView()
        
        NavigationView {
            
            VStack() {
                FlipView(front: front, back: back, showBack: $showBack)
            }
            
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(false)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation(Animation.linear(duration: 0.8)) {
                            self.showBack.toggle()
                        }
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                       // Image(systemName: showBack ? "arrowshape.turn.up.right.circle" : "arrowshape.turn.up.backward.circle")
                        
                        
                    }
                }
            }
        }
    }
}

struct FlipView1_Previews: PreviewProvider {
    static var previews: some View {
        Flip()
    }
}
