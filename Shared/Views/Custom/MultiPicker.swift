//
//  Picker.swift
//  Subs
//
//  Created by Ahmed Magdi on 27/05/2021.
//

import SwiftUI


struct MultiPicker: View  {

    typealias Label = String
    typealias Entry = String

    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]

    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.data.count), height: geometry.size.height)
                    .clipped()
                }
            }
        }
    }
}


#if DEBUG
//DEMO
private struct PickerCustomView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State var data: [(String, [String])] = [
            ("One", Array(0...10).map { "\($0)" }),
            ("Two", Array(20...40).map { "\($0)" }),
            ("Three", Array(100...200).map { "\($0)" })
        ]
    @State var selection: [String] = [0, 20, 100].map { "\($0)" }
    
    
    var body: some View {
        VStack {
        Text(verbatim: "Selection: \(selection)")
        MultiPicker(data: data, selection: $selection)
        }
    }
    
}

struct PickerCustomView_Previews: PreviewProvider {
    @State var data: [(String, [String])] = [
            ("One", Array(0...10).map { "\($0)" }),
            ("Two", Array(20...40).map { "\($0)" }),
            ("Three", Array(100...200).map { "\($0)" })
        ]
    @State var selection: [String] = [0, 20, 100].map { "\($0)" }
    
    static var previews: some View {
        
//        Text(verbatim: "Selection: \(selection)")
        PickerCustomView()
    }
}
#endif






