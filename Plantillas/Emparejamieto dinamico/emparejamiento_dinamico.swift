//
//  parejas.swift
//  APPGeometria
//
//  Created by Macbook Pro 2015 on 9/15/26.
//

import SwiftUI

//Esta es una clase interna que utklizaremos para que la logica de arraste funcione
// Modelo interno que usa la vista para la lógica de arrastre
struct ElementoJuego: Identifiable {
    let id = UUID()
    let nombre: String
    let systemImage: String
    let targetPosition: CGPoint   // Sombra (Destino)
    var initialPosition: CGPoint  // Posición inicial de la ficha
    var currentPosition: CGPoint  // Posición dinámica mientras se arrastra
    var isMatched: Bool = false   // Estado de acierto
}

struct ParejasView: View {
    // Parámetros que recibe desde el selector de niveles
    var idNivel: Int
    var numeroNivel: Int
    
    @State private var elements: [ElementoJuego] = []
    @State private var isLoading: Bool = true
    @State private var errorMessage: String? = nil
    @State private var gameCompleted: Bool = false
    
    @State private var draggedID: UUID? = nil
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            if isLoading {
                ProgressView("Cargando nivel...")
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
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
                                     
                                    // Calcular posición real donde se soltó respecto al origen
                                    let finalX = element.initialPosition.x + value.translation.width
                                    let finalY = element.initialPosition.y + value.translation.height
                                     
                                    // Calcular distancia a la sombra
                                    let distance = hypot(finalX - element.targetPosition.x, finalY - element.targetPosition.y)
                                     
                                    // Margen de tolerancia (ej. 50 puntos)
                                    if distance < 50 {
                                        // ¡Acierto! Imantamos a la posición exacta de la sombra sin penalizar errores
                                        element.currentPosition = element.targetPosition
                                        element.initialPosition = element.targetPosition
                                        element.isMatched = true
                                         
                                        checkIfGameIsFinished()
                                    } else {
                                        // Si falla, simplemente se queda el gesto y regresa suavemente al origen
                                        // (al resetear el offset el sistema lo regresa a currentPosition)
                                    }
                                     
                                    draggedID = nil
                                    dragOffset = .zero
                                }
                        )
                }
                 
                // Alerta de nivel completado (Sin presión de errores)
                if gameCompleted {
                    VStack(spacing: 12) {
                        Text("¡Excelente trabajo!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        Text("Has completado todas las figuras con éxito.")
                            .foregroundColor(.white)
                    }
                    .padding(24)
                    .background(Color.black.opacity(0.85))
                    .cornerRadius(16)
                    .shadow(radius: 10)
                }
            }
        }
        .onAppear {
            cargarDetallesNivel()
        }
        .navigationTitle("Nivel \(numeroNivel)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Función para consumir el Web Service de C#
    func cargarDetallesNivel() {
        APIService.shared.detalles_niveles_match_shadow(id_nivel: idNivel, numero_nivel: numeroNivel) { detalles, error in
            isLoading = false
            if let error = error {
                errorMessage = error
                return
            }
            
            if let detalles = detalles {
                // Mapeamos los datos de la base de datos a nuestros elementos interactivos
                self.elements = detalles.map { item in
                    let target = CGPoint(x: item.coordenada_sombra_x, y: item.coordenada_sombra_y)
                    let initial = CGPoint(x: item.coordenada_ficha_x, y: item.coordenada_ficha_y)
                    return ElementoJuego(
                        nombre: item.nombre_figura,
                        systemImage: item.icono,
                        targetPosition: target,
                        initialPosition: initial,
                        currentPosition: initial
                    )
                }
            }
        }
    }

    func checkIfGameIsFinished() {
        if !elements.isEmpty && elements.allSatisfy({ $0.isMatched }) {
            gameCompleted = true
            // Aquí en el futuro puedes disparar un guardado de puntuación limpia o avanzar de nivel
        }
    }
}
