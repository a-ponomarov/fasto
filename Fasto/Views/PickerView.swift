//
//  PickerView.swift
//  Fasto
//
//  Created by Andrii Ponomarov on 16.11.2022.
//

import SwiftUI

struct PickerView: UIViewRepresentable {
    
    let data: [[String]]
    let widths: [Float]
    
    @Binding var selections: [Int]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIView(_ view: UIPickerView,
                      context: Context) {
        for index in 0..<selections.count {
            view.selectRow(selections[index], inComponent: index, animated: false)
        }
    }

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        
        private let parent: PickerView

        init(_ pickerView: PickerView) {
            parent = pickerView
        }
        
        // MARK: UIPickerViewDataSource

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return parent.data.count
        }

        func pickerView(_ pickerView: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            return parent.data[component].count
        }

        // MARK: UIPickerViewDelegate
        
        func pickerView(_ pickerView: UIPickerView,
                        widthForComponent component: Int) -> CGFloat {
            return pickerView.bounds.width * CGFloat(parent.widths[component])
        }
        
        func pickerView(_ pickerView: UIPickerView,
                        titleForRow row: Int,
                        forComponent component: Int) -> String? {
            return parent.data[component][row]
        }

        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            parent.selections[component] = row
        }
        
    }
    
}
