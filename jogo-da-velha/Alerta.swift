//
//  AlerItem.swift
//  jogo-da-velha
//
//  Created by cassio on 25/05/23.
//

import SwiftUI

struct AlertItem: Identifiable{
    let id = UUID()
    var titulo: Text
    var mensagem: Text
    var botaoTitle: Text
}

struct AlertaContexto {
    
    static let hGanha = AlertItem(titulo: Text("Homer venceu"),
                                mensagem:Text ("Não diga que fui eu!"),
                                botaoTitle: Text("Boa"))
    
    static let mGanha = AlertItem(titulo: Text("D´OH!"),
                                mensagem:Text (" A culpa é minha e eu coloco em quem eu quiser. "),
                                botaoTitle: Text("REVANCHE"))
    
    static let nGanha = AlertItem(titulo: Text("Creio que ninguem ganhou"),
                                mensagem:Text (" Você pode ter todo dinheiro do mundo mas existe algo que você nunca poderá comprar: Um dinossauro. "),
                                botaoTitle: Text(" Novo jogo"))
    
}
