//
//  FrontView.swift
//  CRUD
//
//  Created by David on 19/6/21.
//

import SwiftUI

struct FrontView: View {
    
    @State private var name: String = "David"
    
    var body: some View {
        Color.blue
            .ignoresSafeArea()
            .overlay(
                VStack(spacing: 20) {
                    Text("Front").font(.largeTitle)
                    Text("Example").font(.title).foregroundColor(.white)
                    
                    TextField("Enter your name", text: $name).padding()
                    Text("Hello, \(name)!")
                    
            })
    }
}

struct FrontView_Previews: PreviewProvider {
    static var previews: some View {
        FrontView()
    }
}
