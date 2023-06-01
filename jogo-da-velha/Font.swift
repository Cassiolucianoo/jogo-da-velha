//
//  File.swift
//  jogo-da-velha
//
//  Created by cassio on 24/05/23.
//

import Foundation
import SwiftUI

extension Font {
    static func customFont(size: CGFloat) -> Font {
        if let font = UIFont(name: "gameovercre1", size: size) {
            return Font(font)
        }
        return Font.system(size: size)
    }
}
