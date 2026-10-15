//
//  VentanaIntermediario.swift
//  APPGeometria
//
//  Created by Anderson on 9/20/26.
//
//
//  VentanaIntermediario.swift
//  APPGeometria
//
//  Created by Anderson on 9/20/26.
//

import SwiftUI

struct VentanaIntermediario {
    @ViewBuilder
    static func obtenerVentana(_ nombre: String?) -> some View {
        
        switch nombre {
            
        case "VentanaDefault":
            VentanaDefault()
            
        case "VentanaMatchShadow" :
            VentanaMatchShadow()
            
        default:
            VentanaDefault()
        }
    }
}
