//
//  VentanaMatchShadow.swift
//  APPGeometria
//
//  Created by Anderson on 10/3/26.
//


import SwiftUI

struct VentanaMatchShadow : View{
    var body : some View {
        VStack{
            Text("Relacion de figuras")
                .font(.title)
                .bold()
                .foregroundColor(Color.black)
            
            /*===================Ventana de descripcion (No interactiva) ===================*/
            
            HStack(spacing: 16) {
                // Ícono principal con fondo circular
                Image(systemName: "heart")
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
                    Text("Descripcion")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("Junta las figuras con su respectiva sombra para completar los niveles")
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
            
            /*===================Ventana de practica ===================*/
            
            Button {
                print("Hola mundo")
            }label : {
                HStack(spacing: 16) {
                    // Ícono principal con fondo circular
                    Image(systemName: "filemenu.and.cursorarrow.rtl")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
            
                    
                    // Textos: Nombre y Número
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Practica / Entrenamiento")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("Realiacemos una practica para entender el concepto")
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
            .buttonStyle(.plain)
            
            /*===================Boton para Empezar el minijuego ===================*/
            Spacer()
            
            Button {
                print("Hola mundo")
            }label : {
                HStack(spacing: 16) {
                    // Textos: Nombre y Número
                    VStack(alignment: .center, spacing: 4) {
                        HStack{
                            Image(systemName: "stopwatch")
                            Text("Contra Reloj")
                        }.font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: [.red, .pink],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
                
            }
            .buttonStyle(.plain)
            
            /*===================Boton para empezar el minijuego ===================*/
            
            Button {
                print("Hola mundo")
            }label : {
                HStack(spacing: 16) {
                    // Textos: Nombre y Número
                    VStack(alignment: .center, spacing: 4) {
                        HStack{
                            Image(systemName: "play.fill")
                            Text("Jugar")
                        }.font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
                
            }
            .buttonStyle(.plain)
            
            
        }.background(
            Image("fondo1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.2)
        )
    }
}
#Preview {
    VentanaMatchShadow()
}

