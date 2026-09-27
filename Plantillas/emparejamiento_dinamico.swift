//
//  parejas.swift
//  APPGeometria
//
//  Created by Macbook Pro 2015 on 9/15/26.
//

import SwiftUI

struct Elemento: Identifiable{
    let id = UUID()
    let name: String
    let systemImage: String
    let targetPosition: CGPoint   // Dónde debe encajar (la sombra)
    var initialPosition: CGPoint  // Dónde empieza la figura para arrastrar
    var currentPosition: CGPoint  // Posición dinámica actual
    var isMatched: Bool = false   // Estado para saber si ya lo colocó bien
}

struct parejas: View{
    @State private var elements: [Elemento] = [
        Elemento(name: "Estrella", systemImage: "star.fill", targetPosition: CGPoint(x: 200, y: 300), initialPosition: CGPoint(x: 100, y: 650), currentPosition: CGPoint(x: 100, y: 650)),
        Elemento(name: "Corazón", systemImage: "heart.fill", targetPosition: CGPoint(x: 200, y: 450), initialPosition: CGPoint(x: 300, y: 650), currentPosition: CGPoint(x: 300, y: 650))
    ]
    
    @State private var draggedID: UUID? = nil
    @State private var dragOffset: CGSize = .zero
    
    // Variables para los datos que irán a tu tabla Puntajes
    @State private var errorCount: Int = 0
    @State private var gameCompleted: Bool = false
    
    
    var body: some View {
        ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()

                    // Panel superior con estadísticas (para Puntajes)
                    VStack {
                        HStack {
                            Text("Errores: \(errorCount)")
                                .font(.headline)
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .padding()
                        Spacer()
                    }

                    // 1. Dibujar las Sombras (Destinos fijos)
                    ForEach(elements) { element in
                        Image(systemName: element.systemImage)
                            .font(.system(size: 70))
                            .foregroundColor(.black.opacity(0.2))
                            .position(element.targetPosition)
                    }

                    // 2. Dibujar las Figuras móviles
                    ForEach($elements) { $element in
                        Image(systemName: element.systemImage)
                            .font(.system(size: 70))
                            .foregroundColor(element.isMatched ? .green : .blue)
                            .shadow(radius: 3)
                            .position(element.currentPosition)
                            .offset(draggedID == element.id ? dragOffset : .zero)
                            // Si ya hizo match, desactivamos el gesto para que no se mueva más
                            .disabled(element.isMatched)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        guard !element.isMatched else { return }
                                        draggedID = element.id
                                        dragOffset = value.translation
                                    }
                                    .onEnded { value in
                                        guard !element.isMatched else { return }
                                        
                                        // Calcular posición real donde se soltó
                                        let finalX = element.initialPosition.x + value.translation.width
                                        let finalY = element.initialPosition.y + value.translation.height
                                        
                                        // Calcular distancia a la sombra
                                        let distance = hypot(finalX - element.targetPosition.x, finalY - element.targetPosition.y)
                                        
                                        // Margen de tolerancia (ej. 50 puntos)
                                        if distance < 50 {
                                            // ¡Acierto! Imantamos a la posición exacta de la sombra
                                            element.currentPosition = element.targetPosition
                                            element.initialPosition = element.targetPosition
                                            element.isMatched = true
                                            
                                            // Verificar si completó todos los elementos del nivel
                                            checkIfGameIsFinished()
                                        } else {
                                            // ¡Error! Sumamos un fallo y la figura regresa a su origen
                                            errorCount += 1
                                            // Aquí la figura simplemente se queda en su offset original al soltar el drag
                                        }
                                        
                                        draggedID = nil
                                        dragOffset = .zero
                                    }
                            )
                    }
                    
                    // Alerta de nivel completado
                    if gameCompleted {
                        VStack {
                            Text("¡Nivel Completado!")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                            Text("Total de errores: \(errorCount)")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(12)
                    }
                }
    }
    func checkIfGameIsFinished() {
            if elements.allSatisfy({ $0.isMatched }) {
                gameCompleted = true
                // En este punto, con los datos de 'errorCount' y el tiempo transcurrido,
                // armarías el objeto JSON para enviarlo mediante el Web Service de C# a tu tabla 'Puntajes'.
            }
        }
}
// Preview corregido (sin parámetros vacíos que daban error)
struct Pareja_Previews: PreviewProvider {
    static var previews: some View {
        parejas()
    }
}
