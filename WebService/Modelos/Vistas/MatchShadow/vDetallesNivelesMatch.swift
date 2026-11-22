//
//  vDetallesNivelesMatch.swift
//  APPGeometria
//
//  Created by Anderson on 10/18/26.
//
import Foundation

nonisolated struct vDetallesNivelesMatch : Decodable, Sendable, Identifiable {
    var id : Int {id_detalle}
    let id_detalle : Int
    let id_nivel : Int
    let numero_nivel : Int
    let nombre_figura : String
    let icono : String
    let coordenada_sombra_x : Double
    let coordenada_sombra_y : Double
    let coordenada_ficha_x : Double
    let coordenada_ficha_y : Double
}
