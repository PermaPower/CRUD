//
//  BackView.swift
//  CRUD
//
//  Created by David on 19/6/21.
//

import SwiftUI

struct BackView: View {
    var body: some View {
        Color.purple
            .ignoresSafeArea()
            .overlay(
                VStack(spacing: 20) {
                    Text("Back").font(.largeTitle)
                    Text("Example").font(.title).foregroundColor(.white)
            })
    }
}

struct BackView_Previews: PreviewProvider {
    static var previews: some View {
        BackView()
    }
}
