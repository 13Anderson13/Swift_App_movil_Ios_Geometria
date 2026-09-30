//
//  VentanaDefault.swift
//  APPGeometria
//
//  Created by Anderson on 9/27/26.
//

import SwiftUI

struct VentanaDefault : View {
    var body : some View {
        VStack(alignment : .center, spacing: 16){
            Text("Minijuego no encontrado")
                .font(.title)
                .bold()
            
            Image("Figura2")
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .shadow(radius: 50)
            
            Text("Parece que hubo un problema")
                .bold()
                .foregroundColor(.red)
            
            Text("Por favor, regresa al menu principal")
                .bold()
                
            Button(action:{
                //dismiss()
            })
            {
                Text("Regresar")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Text("Si el problema persiste, ponte en contacto con el equipo de soporte")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

        }.background(Image("fondo3")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .opacity(0.2))
    }
}


#Preview {
    VentanaDefault()
}
