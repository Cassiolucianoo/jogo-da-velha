//
//  AlerItem.swift
//  jogo-da-velha
//
//  Created by cassio on 25/05/23.
//

import SwiftUI
import Foundation

struct AlertaContexto: Identifiable{
    let id = UUID()
    var titulo: Text
    var mensagem: Text
    var botaoTitle: Text
    
    
    
    
    static let hGanha = AlertaContexto(titulo: Text("Homer venceu"),
                                       mensagem:Text ("Não diga que fui eu!"),
                                       botaoTitle: Text("Boa"))
    
    static let mGanha = AlertaContexto(titulo: Text("D´OH!"),
                                       mensagem:Text (" A culpa é minha e eu coloco em quem eu quiser. "),
                                       botaoTitle: Text("REVANCHE"))
    
    static let nGanha = AlertaContexto(titulo: Text("Creio que ninguem ganhou"),
                                       mensagem:Text (" Você pode ter todo dinheiro do mundo mas existe algo que você nunca poderá comprar: Um dinossauro. "),
                                       botaoTitle: Text(" Novo jogo"))
    
}
