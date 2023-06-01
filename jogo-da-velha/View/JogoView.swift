//
//  GameView.swift
//  jogo-da-velha
//
//  Created by cassio on 31/05/23.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JogoViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            Color(.yellow).opacity(0.9)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("LOUCA DOS GATOS")
                    .font(.customFont(size: 20))
                      .fontWeight(.bold)
                
                HStack {
                    ZStack {
                        Image("vs2")
                            .resizable()
                            .zIndex(1)
                            .frame(width: 100, height: 100)
                        
                        Image(viewModel.imgStatusH ? "homer" : "doo3")
                            .resizable()
                            .frame(width: 150, height: 170)
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.white, lineWidth: 6)
                            )
                            .padding(.trailing, 200)
                        
                        VStack {
                            Spacer()
                            
                            Text("  HOMER  ")
                                .font(.custom("ChalkboardSE-Bold", size: 20))
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .opacity(0.8)
                                .padding()
                        }.padding(.trailing, 200)
                        
                        Image(viewModel.imgStatusV ? "velhadogato" : "velhaperde")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.white, lineWidth: 6)
                            )
                            .padding(.leading, 200)
                        
                        VStack {
                            Spacer()
                            
                            Text(" ELEANOR ")
                                .font(.custom("ChalkboardSE-Bold", size: 20))
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .opacity(0.8)
                                .padding()
                        }.padding(.leading, 200)
                    }
                }
                
                LazyVGrid(columns: viewModel.colunas, spacing: 0) {
                    ForEach(0..<9) { i in
                        ZStack {
                            ZStack {
                                Circle()
                            }
                            .foregroundColor(.white)
                            .opacity(10)
                            .frame(width: geometry.size.width / 3 - 15, height: geometry.size.width / 3 - 15)
                            
                            ZStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.yellow)
                                    .opacity(0.4)
                            }
                            
                            Image(viewModel.movimentos[i]?.indicarJogador ?? "")
                                .resizable()
                                .frame(width: 140, height: 140)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            viewModel.processarMovimento(index: i)
                        }
                    }
                }
                .padding()
                
            }
            .disabled(viewModel.jogouFicaSemJogar)
            .padding(.bottom, 70)
            .alert(item: $viewModel.alertItem) { alertaConteudo in
                Alert(
                    title: alertaConteudo.titulo,
                    message: alertaConteudo.mensagem,
                    dismissButton: .default(alertaConteudo.botaoTitle, action: {
                        viewModel.reiniciarPartida()
                    })
                )
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
