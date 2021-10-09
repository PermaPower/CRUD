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
                ZStack(){
 
                VStack(spacing: 0) {
                   
                    TagTop()
                        .frame(width: geometry.size.width-40, height: 80)
                        .foregroundColor(Color.orange)
            
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.orange)
                        .frame(width: .infinity, height: 350)
                    
                    TagBottom()
                        .foregroundColor(Color.orange)
                        .frame(width: geometry.size.width-80, height: 250)
                    
                }
            .compositingGroup()
            .shadow(color: Color.primary, radius: 10, x: 0, y: 0)
            .padding(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
            
            crease()
                .stroke()
                .foregroundColor(Color.red)
                .shadow(color: .blue, radius: 5, x: 5, y: 5)
                    
            crease1()
                 .stroke()
                 .foregroundColor(Color.blue)
                 .shadow(color: .blue, radius: 5, x: -5, y: 5)
        
                }
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

struct crease: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX-80, y: rect.midY+100))
        path.addLine(to: CGPoint(x: rect.midX-10, y: rect.maxY-50))

        return path
    }
 }
    
    struct crease1: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.midX-40, y: rect.midY+150))
            path.addLine(to: CGPoint(x: rect.midX-10, y: rect.maxY-80))

            return path
        }
     }
    
}
