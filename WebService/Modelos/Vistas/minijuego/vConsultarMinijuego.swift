//
//  minijuego.swift
//  APPGeometria
//
//  Created by Anderson on 9/20/26.
//

import Foundation

nonisolated struct vConsultarMinijuego: Decodable, Sendable{
    let id_minijuego : Int
    let nombre_minijuego : String?
    let icono: String?
    let descripcion : String?
}
