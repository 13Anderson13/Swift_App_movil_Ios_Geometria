//
//  minijuego.swift
//  APPGeometria
//
//  Created by Anderson on 9/20/26.
//

import Foundation

nonisolated struct vConsultarMinijuego: Decodable, Sendable, Identifiable{
    var id : Int {id_minijuego} // Essto funciona para decirle al menu (o swift) que cada elemento cuenta con id unico
    let id_minijuego : Int
    let nombre_minijuego : String?
    let icono: String?
    let descripcion : String?
    let ventana : String?
}
