//
//  Extension + MainViewController.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import UIKit

// MARK: - TextFieldDelegate
extension MainViewController: UITextFieldDelegate {

    // Hide the keyboard when tapping outside of Text View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let value = Int(text) {
            
            switch textField.tag {
            case 0:
                matrix?.setMatrixSize(value)
                DataManager.shared.saveData(value, key: Keys.matrixSizeKey)
            case 1:
                matrix?.setNumberOfMatrixes(value)
                DataManager.shared.saveData(value, key: Keys.numberOfMatrixKey)
            default: break
            }
        }
    }
}

extension MainViewController {
    // MARK: - Method to display Done button on the keyboard
    func addDoneButtonTo(_ textField: UITextField) {
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                         target: nil,
                                         action: nil)
        
        keyboardToolbar.items = [flexButton, doneButton]
        textField.inputAccessoryView = keyboardToolbar
        
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}
