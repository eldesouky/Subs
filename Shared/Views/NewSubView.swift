//
//  NewSubView.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import SwiftUI
import Combine

struct NewSubView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel = ViewModel()
    
    init(){
//        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                StyleSheet.Colors.mainBackgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        Button(action: {
                        }) {
                            Image("netflix_logo_2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .background(Color.clear)
                                .padding()
                                .frame(width: 150, height: 150)
                        }
                        
                        TextField("0.00", text: $viewModel.price)
                            .multilineTextAlignment(.center)
                            .frame(width: 200, height: 45, alignment: .center)
                            .border(Color.black, width: 1)
                    }
                    Form {
                        TextInputCell(title: .label_itemName, valuePlaceHolder: .label_itemPlaceholderName, value: $viewModel.name)
                        TextInputCell(title: .label_itemDescription, valuePlaceHolder: .label_itemPlaceholderDescription, value: $viewModel.name)
                        OptionsCell(title: .label_itemCategory)
                        OptionsCell(title: .label_itemColor)
                        TextInputCell(title: .label_itemFirstBill, valuePlaceHolder: .label_itemPlaceholderFirstBill, value: $viewModel.name)
                        OptionsCell(title: .label_itemCycle)
                        OptionsCell(title: .label_itemDuration)
                        OptionsCell(title: .label_itemRemindMe)
                        //                        PickerCell(title: .label_itemCurrency, list: StyleSheet.currencyList())
                    }
                }
            }
            .navigationBarTitle(AppLocal.default[.title_newSubscription], displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(AppLocal.default[.button_cancel])
                },
                trailing:Button(action: viewModel.storeItem) {
                    Text(AppLocal.default[.button_add])
                }.disabled(!viewModel.isDataValid)
            )
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

fileprivate struct PickerCell: View {
    var title: AppLocal.Strings
    var list: [String]
    @State private var selectedFrameworkIndex = ""
    
    var body: some View {
        Section {
            Picker(AppLocal.default[title], selection: $selectedFrameworkIndex) {
                ForEach(list, id:\.self) { item in
                    Text(item)
                }
            }.pickerStyle(WheelPickerStyle())
        }
    }
}

#if DEBUG
struct NewSubView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewSubView()
    }
}

#endif

