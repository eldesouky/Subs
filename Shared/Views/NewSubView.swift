//
//  NewSubView.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import SwiftUI
import Combine
import PartialSheet

struct NewSubView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject var viewModel = ViewModel()
    
    
    init() {
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationView {
            List {
                fieldHeader
                fieldBody
            }
            .navigationBarTitle(AppLocal.default[.title_newSubscription], displayMode: .inline)
            .navigationBarItems( leading: cancelButton, trailing: addButton )
        } .navigationViewStyle(StackNavigationViewStyle())
        .addPartialSheet()
        
    }
    
    private var fieldHeader: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(spacing: 5) {
                ZStack {
                    viewModel.model.color.opacity(0.5).edgesIgnoringSafeArea(.all)
                    
                    viewModel.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.clear)
                        .padding(10)
                    
                    Text("Tab To\nChange")
                        .font(.caption)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }.frame(width: 90, height: 90, alignment: .center)
                .clipShape(Circle())
                
                .onTapGesture(perform: {
                    // open icons and set value imageName
                    viewModel.imageName = "netflix_logo"
                })
                
                CurrencyTextField("Amount", value: $viewModel.model.amount, alwaysShowFractions: false, numberOfDecimalPlaces: 2, currencySymbol: viewModel.model.currency.symbol)
                    .multilineTextAlignment(TextAlignment.center)
                    .frame(width: 150, height: 45, alignment: .center)
                
                //                TextField("0.00", value: $viewModel.amount, formatter: StyleSheet.currencyFormatter)
                //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //                    .multilineTextAlignment(.center)
                //                    .frame(width: 150, height: 45, alignment: .center)
                //                    .keyboardType(.decimalPad)
                
            }
            Spacer()
        }
    }
    
    private var fieldBody: some View {
        Group {
            TextInputCell(title: .label_itemName, valuePlaceHolder: .label_itemPlaceholderName, value: $viewModel.model.name)
            TextInputCell(title: .label_itemDescription, valuePlaceHolder: .label_itemPlaceholderDescription, value: $viewModel.model.detail)
            ColorPickerCell(title: .label_itemColor, value: $viewModel.model.color)
            
            datePickerCell
            CyclePickerCell(title: .label_itemCycle, value: $viewModel.model.cycle, selection1: $viewModel.selection1, selection2: $viewModel.selection2)
            OptionsCell(title: .label_itemDuration)
            OptionsCell(title: .label_itemRemindMe)
        }
    }
    
    private var addButton: some View {
        Button(action: {
            if viewModel.storeItem() {
                presentationMode.wrappedValue.dismiss()
            }
            else {
                print("fail")
            }
        }) {
            Text(AppLocal.default[.button_add])
        }.disabled(!viewModel.isDataValid)
    }
    
    private var cancelButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text(AppLocal.default[.button_cancel])
        }
    }
    
    private var datePickerCell: some View {
        DatePicker(AppLocal.default[.label_itemFirstBill], selection: $viewModel.model.firstBill, displayedComponents: .date)
            .datePickerStyle(CompactDatePickerStyle())
    }
}

fileprivate struct TextInputCell: View {
    @State var title: AppLocal.Strings
    @State var valuePlaceHolder: AppLocal.Strings
    @Binding var value: String
    var body: some View {
        HStack {
            Text(AppLocal.default[title])
            Spacer()
            TextField(AppLocal.default[valuePlaceHolder], text: $value)
                .multilineTextAlignment(.trailing)
        }
    }
}

fileprivate struct OptionsCell: View {
    @State var title: AppLocal.Strings
    var body: some View {
        HStack {
            Text(AppLocal.default[title])
            Spacer()
        }
    }
}

fileprivate struct CyclePickerCell: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager

    @State var title: AppLocal.Strings
    @Binding var value: Cycle
    
    @Binding var selection1: Int
    @Binding var selection2: Int

    var body: some View {
        let cyclePicker = MultiSegmentPickerViewModel(segments: [
            ("p1", $selection1, Cycle.pickerColoumOne()), // Values for first segment
            ("p2", $selection2, Cycle.periodOptions()) // Values for second segment
        ])
         
        HStack {
            Text(AppLocal.default[title])
            Spacer()
            Text(value.stringValue)
        }
        .onTapGesture {
            self.partialSheetManager.showPartialSheet {
                MultiSegmentPickerView(viewModel: cyclePicker)
                    .frame(height: 250)
                    .ignoresSafeArea()
            }
        }
    }
    
}


fileprivate struct ColorPickerCell: View {
    var title: AppLocal.Strings
    @Binding var value: Color
    
    var body: some View {
        ColorPicker(AppLocal.default[title], selection: $value, supportsOpacity: false)
    }
}





#if DEBUG

struct NewSubView_Previews: PreviewProvider {
    

    static var previews: some View {
        let sheetManager: PartialSheetManager = PartialSheetManager()

        NewSubView()
            .preferredColorScheme(.dark)
            .environmentObject(sheetManager)
    }
}
#endif




