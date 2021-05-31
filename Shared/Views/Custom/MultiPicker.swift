//
//  Picker.swift
//  Subs
//
//  Created by Ahmed Magdi on 27/05/2021.
//

import SwiftUI

struct MultiSegmentPickerViewModel {
    typealias Label = String // The label for each picker
    typealias Selection = Binding<Int> // The selection index for each picker
    typealias PickerDisplayValues = [String] // The respective values for the picker
    
    // A multi-segment picker is composed of an array of the above types
    var segments: [(Label, Selection, PickerDisplayValues)] = []
    
    init() {}
    init(segments: [(Label, Selection, PickerDisplayValues)]) {
        self.segments = segments
    }
}


struct MultiSegmentPickerView: View {
    
    let viewModel: MultiSegmentPickerViewModel
    
    @State var height: CGFloat? = nil
    
    var body: some View {
        GeometryReader { geometry in
            
            HStack {
                // 3 Iterate over the individual picker values
                ForEach(0..<self.viewModel.segments.count, id: \.self) { pickerIndex in
                    // Define a picker
                    Picker(
                        self.viewModel.segments[pickerIndex].0, // Label
                        selection: self.viewModel.segments[pickerIndex].1 // Selection
                    ) {
                        ForEach(0..<self.viewModel.segments[pickerIndex].2.count) { pickerSelectionIndex in
                            Text(self.viewModel.segments[pickerIndex].2[pickerSelectionIndex])
                                // Tag tells SwiftUI which selection to show - we tag with the index
                                .tag(pickerSelectionIndex)
                            
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.viewModel.segments.count), height: geometry.size.height)
                    // 5 Clip to the given width, otherwise the picker lines will overflow & intersect
                    .clipped()
                }
            }
        }
    }
}

#if DEBUG
//DEMO
private struct PickerCustomView: View {
    
    @State var data: [(String, [String])] = [
        ("One", Array(0...10).map { "\($0)" }),
        ("Two", Array(20...40).map { "\($0)" }),
        ("Three", Array(100...200).map { "\($0)" })
    ]
    @State var selection: [String] = [0, 20, 100].map { "\($0)" }
    
    var body: some View {
        let testVm = MultiSegmentPickerViewModel(segments: [
            ("FirstPicker", .constant(0), ["1.1", "1.2", "1.3"]), // Values for first segment
            ("SecondPicker", .constant(1), ["2.1", "2.2", "2.3"]), // Values for second segment
        ])
        MultiSegmentPickerView(viewModel: testVm)
    }
}

struct PickerCustomView_Previews: PreviewProvider {
    static var previews: some View {
        PickerCustomView()
    }
}
#endif






