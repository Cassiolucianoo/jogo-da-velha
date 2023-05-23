//
//  ContentView.swift
//  jogo-da-velha
//
//  Created by cassio on 22/05/23.
//

import SwiftUI


let colunas: [GridItem] = [GridItem(.flexible()),  GridItem(.flexible()), GridItem(.flexible()),]

struct ContentView: View {
    var body: some View {
        
        
        /* GeometryReader é um contêiner de visualização que permite acessar informações de layout e geometria da visualização pai. A palavra-chave in é usada para delimitar o escopo da cláusula de fechamento. */
        GeometryReader{ geometry in
            
            VStack {
                Spacer()
                
                /* LazyVGrid(columns: colunas) {: LazyVGrid é um contêiner de visualização que organiza as visualizações em um layout de grade verticalmente. O parâmetro columns define o número de colunas na grade.*/
                LazyVGrid(columns: colunas){
                    
                    /*  ForEach é usado para iterar sobre uma sequência e criar visualizações para cada elemento. Neste caso, estamos criando 9 visualizações, numeradas de 0 a 8, e atribuindo cada valor à variável i. */
                    ForEach(0..<9){ i in
                        ZStack{
                            
                            Button(action: {
                                
                                print(i)
                                // Ação a ser executada quando o botão for pressionado
                            }) {
                                Image("donut1")
                                // O método resizable() permite que a imagem se ajuste ao tamanho especificado.
                                    .resizable()
                                // Aqui estamos definindo o tamanho do quadro da imagem como 100x100 pontos.
                                    .frame(width:100,height: 100)
                                
                            }
                        }
                    }
                }
                // Cria um espaço vazio abaixo do conteúdo.
                Spacer()
            }
            //Adiciona preenchimento ao redor do conteúdo para criar um espaço adicional.
            .padding()
        }
    }
}
/* Aqui, estamos definindo uma enumeração chamada Jogador. Essa enumeração possui dois casos: jogador e maquina, que representam os possíveis jogadores em um jogo. */
enum Jogador{
    case jogador, maquina
}

/* struct Move {: Estamos definindo uma estrutura chamada Move. Essa estrutura possui duas propriedades:
 jogador: uma instância da enumeração Jogador, que representa o jogador responsável pela jogada.
 quadroIndex: um inteiro que representa o índice do quadro (ou posição) em que a jogada foi feita. */
struct Move {
    let jogador: Jogador
    let  quadroIndex: Int
    
    
    /* Aqui, estamos declarando uma propriedade computada chamada indicarJogador, que retorna uma string. Essa propriedade não possui um bloco de código explícito, mas usa a sintaxe do operador ternário para retornar diferentes strings com base no caso da enumeração Jogador:
     
     Se jogador for igual a .maquina, a propriedade retorna a string "donut1".
     Caso contrário, se jogador for igual a .jogador, a propriedade retorna a string "donut2". */
    var indicarJogador: String{
        return jogador == .maquina ? "donut1" : "donut2"
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
