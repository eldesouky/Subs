//
//  NewSubView.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import SwiftUI
import Combine

struct NewSubView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject var viewModel = ViewModel()
    
    init() {
//        _viewModel = .init(wrappedValue: viewModel)
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                viewModel.color.edgesIgnoringSafeArea(.all)
                List {
                    fieldHeader
                    fieldBody
                }
            }
            .navigationBarTitle(AppLocal.default[.title_newSubscription], displayMode: .inline)
            .navigationBarItems( leading: cancelButton, trailing: addButton )
        }
    }
    
    private var fieldHeader: some View {
        
        HStack(spacing: 0) {
            ZStack {
                Color.random.opacity(0.5).edgesIgnoringSafeArea(.all)

                viewModel.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(Color.clear)
                    .padding()
                
                Text("Tab To\nChange")
                    .font(.caption)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }.frame(width: 150, height: 150, alignment: .center)
            .onTapGesture(perform: {
                // open icons and set value imageName
                viewModel.imageName = "netflix_logo"
            })
            TextField("0.00", value: $viewModel.amount, formatter: StyleSheet.currencyFormatter)
//            TextField("0.00 \(viewModel.currency)", text: $viewModel.price)
                .multilineTextAlignment(.center)
                .frame(height: 45, alignment: .center)
                .border(Color.black, width: 1)
                .keyboardType(.decimalPad)
        }
        .cornerRadius(10)
    }
    
    private var fieldBody: some View {
        Group {
            TextInputCell(title: .label_itemName, valuePlaceHolder: .label_itemPlaceholderName, value: $viewModel.name)
            TextInputCell(title: .label_itemDescription, valuePlaceHolder: .label_itemPlaceholderDescription, value: $viewModel.name)
            OptionsCell(title: .label_itemCategory)
            ColorPickerCell(title: .label_itemColor, value: $viewModel.color)
            PickerCell(title: .label_itemCurrency, list: StyleSheet.currencyList())
            
            DatePickerCell(title: .label_itemFirstBill, value: $viewModel.firstBillDate)
            CyclePickerCell(title: .label_itemCycle)
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
    @State var title: AppLocal.Strings
//    @Binding var value: String
    
    @State private var data = [ ("numbers",Array(1...30).map { "\($0)" }),
                         ("periods", TimePeriodCategory.valuesList())]
    
    @State var selection: [String] = ["1", TimePeriodCategory.month.value]
    
    @State var showPicker: Bool = false
    var body: some View {
        VStack {
            Text(AppLocal.default[title])
            MultiPicker(data: data, selection: $selection)
                .frame(height: 40)
        }
    }
}


fileprivate struct PickerCell: View {
    var title: AppLocal.Strings
    var list: [String]
    @State private var selectedFrameworkIndex = ""
    
    var body: some View {
        Picker(AppLocal.default[title], selection: $selectedFrameworkIndex) {
            ForEach(list, id:\.self) { item in
                Text(item)
            }
        }.frame(height: 40)
    }
}

fileprivate struct ColorPickerCell: View {
    var title: AppLocal.Strings
    @Binding var value: Color
    
    var body: some View {
        ColorPicker(AppLocal.default[title], selection: $value)
    }
}

fileprivate struct DatePickerCell: View {
    var title: AppLocal.Strings
    @Binding var value: Date
    
    var body: some View {
        //        HStack {
//                    Text(AppLocal.default[title])
        //            Spacer()
        DatePicker(AppLocal.default[title], selection: $value, displayedComponents: .date)
            .datePickerStyle(CompactDatePickerStyle())
        //        }
    }
}



#if DEBUG
struct NewSubView_Previews: PreviewProvider {
    static var previews: some View {

        NewSubView()
    }
}
#endif




