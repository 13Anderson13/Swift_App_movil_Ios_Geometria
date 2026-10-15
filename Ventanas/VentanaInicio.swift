//
//  VentanaInicio.swift
//  APPGeometria
//
//  Created by Macbook Pro 2015 on 9/15/26.
//
import SwiftUI

struct VentanaInicio : View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    // Variables de estado para almacenar la lista que viene del eb service
    @State private var minijuegos: [vConsultarMinijuego] = []
    @State private var mensajeError: String? = nil
    @State private var minijuegoSeleccionado: vConsultarMinijuego?

    
    var body : some View {
        ZStack{
            NavigationView(){
                ScrollView{
                    Text("Selecciona un o minijuego de la lista para comenzar con las actividades disponibles")
                        .font(.subheadline)
                        //Aca mandamos a llamar el endpoint de consultar menu (o minijuegos)
                        ForEach(minijuegos, id: \.id_minijuego){ item in
                            menudinamico(
                                nombre: item.nombre_minijuego ?? "Proximamente",
                                icono: item.icono ?? "star.fill",
                                identificador: Int32(item.id_minijuego),
                                descripcion: item.descripcion ?? "Sin descripcion",
                                ventana: item.ventana,
                                accion : {
                                    minijuegoSeleccionado = item
                                    VentanaIntermediario.obtenerVentana(item.ventana)

                                }
                            )
                        }
                }
                .navigationTitle("Minijuegos")
                .background(
                    Image("fondo2")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .opacity(0.2)
                    )
            }
            .sheet(item: $minijuegoSeleccionado) { item in
                      
                      VentanaIntermediario.obtenerVentana(
                          item.ventana
                      )
                  }
        }
        
        .onAppear{
            obtenerMenu()
        }
    }
    
    private func obtenerMenu()
    {
        APIService.shared.menu { listaMinijuegos, error in
            if let error = error{
                self.mensajeError = error
                print("Error al cargar elementos del menu: \(error)")
                return
            }
            
            if let listaMinijuegos = listaMinijuegos {
                self.minijuegos = listaMinijuegos
            }
        }
    }
    
}

#Preview {
    VentanaInicio()
}
