//
//  CustomTextField.swift
//  Weathermail
//
//  Created by Atsuhiro Muroyama on 2022/05/22.
//

import UIKit

final class CustomTextField: UITextField {
//このクラスで、textfieldに望まない入力が入るのを防止する。
    //入力キャレットを非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    //範囲選択カーソルの非表示
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    // コピー・ペースト・選択等のメニューを非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    override func layoutSubviews() {
         super.layoutSubviews()

        //self.frame.size.height = 50 //
        //self.frame.size.width = UIScreen.main.bounds.size.width / 2
        //コードで書くのと相性が悪い。。。？
    }
}
