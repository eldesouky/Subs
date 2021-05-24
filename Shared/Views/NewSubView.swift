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
                viewModel.color.edgesIgnoringSafeArea(.all)
                Form {
                    HStack(spacing: 0) {
                        ZStack {
                            Image("netflix_logo_2")
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
                            
                        })
                        
                        TextField("0.00", text: $viewModel.price)
                            .multilineTextAlignment(.center)
                            .frame(height: 45, alignment: .center)
                            .border(Color.black, width: 1)
                    }
                    Section {
                        TextInputCell(title: .label_itemName, valuePlaceHolder: .label_itemPlaceholderName, value: $viewModel.name)
                        TextInputCell(title: .label_itemDescription, valuePlaceHolder: .label_itemPlaceholderDescription, value: $viewModel.name)
                        OptionsCell(title: .label_itemCategory)
                        ColorPickerCell(title: .label_itemColor, value: $viewModel.color)
                        PickerCell(title: .label_itemCurrency, list: StyleSheet.currencyList())
                        
                        DatePickerCell(title: .label_itemFirstBill, value: $viewModel.firstBillDate)
                        OptionsCell(title: .label_itemCycle)
                        OptionsCell(title: .label_itemDuration)
                        OptionsCell(title: .label_itemRemindMe)
                    }
                    
                    Section {
                        
                    }.foregroundColor(viewModel.color)
                }
            }.onAppear {
                UITableViewCell.appearance().backgroundColor = UIColor.clear
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
        Picker(AppLocal.default[title], selection: $selectedFrameworkIndex) {
            ForEach(list, id:\.self) { item in
                Text(item)
            }
        }
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
        DatePicker(AppLocal.default[title], selection: $value, displayedComponents: .date)
            .datePickerStyle(CompactDatePickerStyle())
    }
}


#if DEBUG
struct NewSubView_Previews: PreviewProvider {
    static var previews: some View {
        NewSubView()
    }
}
#endif

