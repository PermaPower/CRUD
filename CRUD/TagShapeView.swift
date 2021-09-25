//
//  TagShapeView.swift
//  CRUD
//
//  Created by David on 27/6/21.
//

import SwiftUI

struct TagShapeView: View {
    var body: some View {
        
        ScrollView() {
            GeometryReader { (geometry) in
                VStack(spacing: 0) {
                   
                    TagTop()
                        .frame(width: geometry.size.width-40, height: 80)
                        .foregroundColor(Color.red)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.orange)
                        .frame(width: .infinity, height: 350)
                    
                    TagBottom()
                        .foregroundColor(Color.orange)
                        .frame(width: geometry.size.width-80, height: 150)
                }
            }
            .compositingGroup()
            .shadow(color: Color.primary, radius: 10, x: 0, y: 0)
            .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct TagTop: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.minY-50))
        path.closeSubpath()
        return path
    }
    
}

struct TagBottom: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        return path
    }
}

struct TagShapeView_Previews: PreviewProvider {
    static var previews: some View {
        TagShapeView()
    }
}
