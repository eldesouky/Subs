//
//  Test.swift
//  Subs
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import SwiftUI
import UIKit

struct TestTextfield: UIViewRepresentable {

    @Binding var text: String
    var keyType: UIKeyboardType

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = keyType

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(context.coordinator.cancelButtonTapped(button:)))
        let clearButton = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(context.coordinator.clearButtonTapped(button:)))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(context.coordinator.doneButtonTapped(button:)))

        toolBar.setItems([cancelButton, spacer, clearButton, spacer, doneButton], animated: true)
        textField.inputAccessoryView = toolBar

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, UITextFieldDelegate {

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            print("TextField Should Return")
            textField.resignFirstResponder()
            return true
        }

        override init() {
            print("Keyboard Buttons")
        }

        @objc func cancelButtonTapped(button:UIBarButtonItem) -> Void {
           print("Cancel Button Tapped")
        }

        @objc func clearButtonTapped(button:UIBarButtonItem) -> Void {
           print("Clear Button Tapped")
        }

        @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
            print("Done Button Tapped")
        }
    }
}

struct darkTextField: ViewModifier {
    func body(content: Content) -> some View {

        content
            .padding(.horizontal, 30)
            .padding(.vertical, 5)
            .background(Color.white)
            .cornerRadius(10)
    }
}

extension View {
    func darkTextFieldStyle() -> some View {
        self.modifier(darkTextField())
    }
}



extension UITextField {

    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
}

final class DatePickerTextField: UITextField {
    @Binding var date: Date?
    private let datePicker = UIDatePicker()
    
    init(date: Binding<Date?>, frame: CGRect) {
        self._date = date
        super.init(frame: frame)
        inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerDidSelect(_:)), for: .valueChanged)
        datePicker.datePickerMode = .date
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(dismissTextField))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        inputAccessoryView = toolBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func datePickerDidSelect(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    @objc private func dismissTextField() {
        resignFirstResponder()
    }
    
}

struct DatePickerInputView: UIViewRepresentable {
    @Binding var date: Date?
    let formatter: Formatter?
    let placeholder: String
    
    init(date: Binding<Date?>, placeholder: String, formatter: Formatter) {
        self._date = date
        self.placeholder = placeholder
        self.formatter = formatter
    }
    
    func updateUIView(_ uiView: DatePickerTextField, context: Context) {
        if let date = date {
            uiView.text = "\(date)"
        }
    }
    
    func makeUIView(context: Context) -> DatePickerTextField {
        let dptf = DatePickerTextField(date: $date, frame: .zero)
        dptf.placeholder = placeholder
        if let date = date {
            dptf.text = "\(date)"
        }
        
        return dptf
    }
    
}
