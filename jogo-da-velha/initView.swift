//
//  ContentView.swift
//  jogo-da-velha
//
//  Created by cassio on 22/05/23.
//

import SwiftUI

var nome =  "vish"

struct ContentView: View {
    
    let colunas: [GridItem] = [GridItem(.flexible()),  GridItem(.flexible()), GridItem(.flexible()),]
    
    @State private var movimentos: [Mover?] = Array(repeating: nil, count: 9)
    @State private var jogouFicaSemJogar = false
    
    var body: some View {
        
        /* GeometryReader é um contêiner de visualização que permite acessar informações de layout e geometria da visualização pai. A palavra-chave in é usada para delimitar o escopo da cláusula de fechamento. */
        GeometryReader{ geometry in
            Color(.yellow).opacity(0.9)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                /* LazyVGrid(columns: colunas) {: LazyVGrid é um contêiner de visualização que organiza as visualizações em um layout de grade verticalmente. O parâmetro columns define o número de colunas na grade.*/
                LazyVGrid(columns: colunas, spacing: 0){
                    
                    /*  ForEach é usado para iterar sobre uma sequência e criar visualizações para cada elemento. Neste caso, estamos criando 9 visualizações, numeradas de 0 a 8, e atribuindo cada valor à variável i. */
                    ForEach(0..<9){ i in
                        
                        ZStack{
                            
                            ZStack{
                                
                                Circle()
                            }
                                .foregroundColor(.white).opacity(10)
                                .frame(width: geometry.size.width / 3 - 15,
                                       height: geometry.size.width / 3 - 15)
                            ZStack{
                                Circle()
                                    .frame(width:40,height: 40)
                                    .foregroundColor(.yellow).opacity(0.4)
                            }
                            
                            Image(movimentos[i]?.indicarJogador ?? "")
                            // O método resizable() permite que a imagem se ajuste ao tamanho especificado.
                                .resizable()
                            // Aqui estamos definindo o tamanho do quadro da imagem como 100x100 pontos.
                                .frame(width:140,height: 140)
                                .foregroundColor(.white)
                            
                        }.onTapGesture {
                            
                            if posicaoOcupada(in: movimentos, forIndex: i){ return }
                            movimentos[i] = Mover(jogador: .humano, quadroIndex: i)
                            jogouFicaSemJogar = true
                            //  movimentos[i] = Move(jogador: partidaDoJogador ? .humano: .maquina, quadroIndex: i)
                            //partidaDoJogador.toggle()
                            
                            if verificarVencedor(for: .humano, in: movimentos){
                                print("Vitoria do homer")
                                return
                            }
                            if verificaImpate(in: movimentos){
                                print("Impate")
                                return
                            }
                            
                            //check for win condition or draw
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                
                                let maquinaPosicao = determinaMaquinaMoverPosicao(in: movimentos )
                                movimentos[maquinaPosicao] = Mover(jogador: .maquina, quadroIndex: maquinaPosicao)
                                jogouFicaSemJogar =  false
                                
                                if verificarVencedor(for: .maquina, in: movimentos){
                                    print("Vitoria da maquina")
                                    return
                                }
                                if verificaImpate(in: movimentos){
                                    print("Impate")
                                    return
                                }
                            }
                        }
                    }
                }
                // Cria um espaço vazio abaixo do conteúdo.
                Spacer()
            }
            .disabled(jogouFicaSemJogar)
            //Adiciona preenchimento ao redor do conteúdo para criar um espaço adicional.
            .padding()
            
        }
    }
    func posicaoOcupada(in moves: [Mover?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.quadroIndex == index })
    }
    
    func determinaMaquinaMoverPosicao(in moves: [Mover?]) -> Int{
        var movimentaPosicao = Int.random(in: 0..<9)
        
        while posicaoOcupada(in: moves, forIndex: movimentaPosicao) {
            movimentaPosicao = Int.random(in: 0..<9)
        }
        
        return movimentaPosicao
    }
    
    func verificarVencedor(for jogador: Jogador, in movimento: [Mover?]) -> Bool{
        
        let vitoriaPadrao: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7 , 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let movimentoJogador = movimento.compactMap {$0}.filter { $0.jogador == jogador }
        let playerPositions = Set(movimentoJogador.map { $0.quadroIndex})
       
        for padrao in vitoriaPadrao {
              if padrao.isSubset(of: playerPositions) {
                  return true
              }
          }
        
        return false
    }
    func verificaImpate(in movimentos: [Mover?])-> Bool{
        return movimentos.compactMap{ $0 }.count == 9
    }
}

/* Aqui, estamos definindo uma enumeração chamada Jogador. Essa enumeração possui dois casos: jogador e maquina, que representam os possíveis jogadores em um jogo. */
enum Jogador{
    case humano, maquina
}

/* struct Move {: Estamos definindo uma estrutura chamada Move. Essa estrutura possui duas propriedades:
 jogador: uma instância da enumeração Jogador, que representa o jogador responsável pela jogada.
 quadroIndex: um inteiro que representa o índice do quadro (ou posição) em que a jogada foi feita. */
struct Mover {
    let jogador: Jogador
    let  quadroIndex: Int
    
    
    /* Aqui, estamos declarando uma propriedade computada chamada indicarJogador, que retorna uma string. Essa propriedade não possui um bloco de código explícito, mas usa a sintaxe do operador ternário para retornar diferentes strings com base no caso da enumeração Jogador:
     
     Se jogador for igual a .humano, a propriedade retorna a string "donut1".
     Caso contrário, se jogador for igual a .jogador, a propriedade retorna a string "donut2". */
    var indicarJogador: String{
        return jogador == .humano ? "donut1" : "donut2"
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
