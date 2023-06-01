//
//  GameViewModel.swift
//  jogo-da-velha
//
//  Created by cassio on 31/05/23.
//

import Foundation
import SwiftUI


class JogoViewModel: ObservableObject {
    let colunas: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @Published var movimentos: [Mover?] = Array(repeating: nil, count: 9)
    @Published var jogouFicaSemJogar = false
    @Published var alertItem: AlertaContexto?
    @Published var imgStatusH = true
    @Published var imgStatusV = true
    
    func processarMovimento(index: Int) {
        if posicaoOcupada(in: movimentos, forIndex: index) { return }
        
        movimentos[index] = Mover(jogador: .humano, quadroIndex: index)
        
        if verificarVencedor(for: .humano) {
            alertItem = AlertaContexto.hGanha
            imgStatusV.toggle()
            return
        }
        
        if verificaEmpate() {
            alertItem = AlertaContexto.nGanha
            return
        }
        
        jogouFicaSemJogar = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let maquinaPosicao = self.determinaMaquinaMoverPosicao()
            self.movimentos[maquinaPosicao] = Mover(jogador: .maquina, quadroIndex: maquinaPosicao)
            self.jogouFicaSemJogar = false
            
            if self.verificarVencedor(for: .maquina) {
                self.alertItem = AlertaContexto.mGanha
                self.imgStatusH.toggle()
                return
            }
            
            if self.verificaEmpate() {
                self.alertItem = AlertaContexto.nGanha
                return
            }
        }
    }
    
    func posicaoOcupada(in movimentos: [Mover?], forIndex index: Int) -> Bool {
        return movimentos.contains(where: { $0?.quadroIndex == index })
    }
    
    func determinaMaquinaMoverPosicao() -> Int {
        var movimentaPosicao = Int.random(in: 0..<9)
        
        while posicaoOcupada(in: movimentos, forIndex: movimentaPosicao) {
            movimentaPosicao = Int.random(in: 0..<9)
        }
        
        return movimentaPosicao
    }
    
    func verificarVencedor(for jogador: Jogador) -> Bool {
        let vitoriaPadrao: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7 , 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let movimentoJogador = movimentos.compactMap { $0 }.filter { $0.jogador == jogador }
        let playerPositions = Set(movimentoJogador.map { $0.quadroIndex })
        
        for padrao in vitoriaPadrao {
            if padrao.isSubset(of: playerPositions) {
                return true
            }
        }
        
        return false
    }
    
    func verificaEmpate() -> Bool {
        return movimentos.compactMap { $0 }.count == 9
    }
    
    func reiniciarPartida() {
        movimentos = Array(repeating: nil, count: 9)
        imgStatusH = true
        imgStatusV = true
    }
}
