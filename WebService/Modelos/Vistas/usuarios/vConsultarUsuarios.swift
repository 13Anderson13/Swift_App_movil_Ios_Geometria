//
//  vConsultarUsuarios.swift
//  APPGeometria
//
//  Created by Macbook Pro 2015 on 9/15/26.
//
import Foundation

nonisolated struct vConsultarUsuarios: Decodable, Sendable{
    let id_usuarios : Int
    let login : String
    let password : String?
    let nombre : String
    let apellido : String
}
