//
//  menudinamico.swift
//  APPGeometria
//
//  Created by Anderson on 9/20/26.
//

import SwiftUI

struct menudinamico : View{
    
    let nombre: String
    let icono: String
    let identificador: Int32
    let descripcion : String
    
    var body : some View {
        HStack(spacing: 16) {
            // Ícono principal con fondo circular
            Image(systemName: icono)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(red: 0.98, green: 0.2, blue: 0.45), // Rosa / Magenta
                                Color(red: 0.95, green: 0.35, blue: 0.15), // Rojo
                                Color(red: 0.99, green: 0.6, blue: 0.15)   // Naranja
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            
            // Textos: Nombre y Número
            VStack(alignment: .leading, spacing: 4) {
                Text("\(identificador) - \(nombre)")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Descripcion: \(descripcion)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}


#Preview{
    menudinamico(nombre: "Elemento disponible", icono: "person.crop.circle.fill", identificador: 1, descripcion: "")
}
