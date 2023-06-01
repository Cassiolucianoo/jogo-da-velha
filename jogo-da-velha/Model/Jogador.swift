//
//  Player.swift
//  jogo-da-velha
//
//  Created by cassio on 31/05/23.
//

import Foundation

enum Jogador {
    case humano, maquina
}

struct Mover {
    let jogador: Jogador
    let quadroIndex: Int
    
    var indicarJogador: String {
        return jogador == .humano ? "donut1" : "gato"
    }
}
