//
//  ContentView.swift
//  CustomShape
//
//  Created by Pavel Bondar on 11/2/19.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import SwiftUI

struct CircleShape: Shape {
    
    let progress: Double
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .radians(1.5 * .pi),
                    endAngle: .init(radians: 2 * Double.pi * progress + 1.5 * Double.pi),
                    clockwise: false)
        return path
    }
}

struct ContentView: View {
    
    @State var pickerItem = 0
    
    @State var circleValues: [[Double]] = [
        [0.2, 0.9, 0.5],
        [0.9, 0.1, 0.3],
        [0.6, 0.4, 0.7]
    ]
    
    @State var diagramValues: [[CGFloat]] = [
        [30, 90, 160],
        [45, 156, 87],
        [175, 34, 79]
    ]
    var body: some View {
        ZStack {
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Analytics").font(.system(size: 32)).fontWeight(.heavy)
                Picker(selection: $pickerItem, label: Text("")) {
                    Text("September").tag(0)
                    Text("October").tag(1)
                    Text("November").tag(2)
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 16)
                HStack {
                    CircleView(value: circleValues[pickerItem][0])
                    CircleView(value: circleValues[pickerItem][1])
                    CircleView(value: circleValues[pickerItem][2])
                }.padding(.top, 16).animation(.default)
                HStack {
                    DiagramView(value: diagramValues[pickerItem][0])
                    DiagramView(value: diagramValues[pickerItem][1])
                    DiagramView(value: diagramValues[pickerItem][2])
                }.padding(.top, 16).animation(.spring())
                Spacer()
            }
        }
    }
}

struct CircleView: View {
    
    private var color: Color {
        if value < 0.3 {
            return .orange
        } else if value > 0.3 && value < 0.7 {
            return .purple
        } else {
            return .secondary
        }
    }
    
    var value: Double
    var body: some View {
        ZStack(alignment: .center) {
            CircleShape(progress: 1).stroke(Color.white, style: StrokeStyle(lineWidth: 15,
                                                                              lineCap: .butt,
                                                                              lineJoin: .round,
                                                                              miterLimit: 0,
                                                                              dash: [],
                                                                              dashPhase: 0))
            CircleShape(progress: value).stroke(color, style: StrokeStyle(lineWidth: 10,
            lineCap: .round,
            lineJoin: .round,
            miterLimit: 0,
            dash: [],
            dashPhase: 0))
            Text(String(value * 100) + "%")
        }.padding()
    }
}

struct DiagramView: View {
    
    var value: CGFloat
    
    private var color: Color {
        if value < 80 {
            return .yellow
        } else if value > 80 && value < 130 {
            return .green
        } else {
            return .red
        }
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle().frame(width: 30, height: 200).foregroundColor(Color.white)
                Rectangle().frame(width: 30, height: value).foregroundColor(color)
            }.padding(.top, 16)
            Text("03").padding(.top, 4)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
