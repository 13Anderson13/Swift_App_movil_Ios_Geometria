//
//  vNivelesMatch.swift
//  APPGeometria
//
//  Created by Anderson on 10/18/26.
//

import Foundation

nonisolated struct vNivelesMatch : Decodable, Sendable, Identifiable{
    var id : Int {id_nivel}
    let id_nivel : Int
    let numero_nivel : Int
    let id_minijuego : Int
    let titulo_nivel : String
    let dificultad : Int
    let estado : Bool
}
