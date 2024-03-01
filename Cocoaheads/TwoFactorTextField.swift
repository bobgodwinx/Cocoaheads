import UIKit
import SwiftUI


struct TwoFactorTextField: UIViewRepresentable {
    
    typealias UIViewType = UITextField

    @Binding var bindable: String
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        print("\(String(describing: uiView.text))")
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        let spacing = 20
        textField.textColor = .white
        textField.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        textField.keyboardType = .numberPad
        textField.defaultTextAttributes.updateValue(spacing, forKey: .kern)
        textField.attributedPlaceholder = NSAttributedString(string: "______", attributes: [.kern : spacing, .foregroundColor: UIColor.white])
        // The magic happens here
        textField.delegate = context.coordinator
        return textField
    }
}

extension TwoFactorTextField {

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TwoFactorTextField
        private let maxLenght = 6

        init(_ parent: TwoFactorTextField) {
            self.parent = parent
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            guard let currentText = textField.text else { return true }

            let addedStringsCount = string.count
            let removedStringsCount = range.length
            let newLength = currentText.count + addedStringsCount - removedStringsCount

            if newLength == maxLenght {
                textField.text = currentText + string
                textField.resignFirstResponder()
            }

            return newLength <= maxLenght
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            // update the `SwiftUI`
            guard let text = textField.text else { return }
            parent.bindable = text
        }
    }
}
