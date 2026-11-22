//
//  SelectorNivelMatch.swift
//  APPGeometria
//
//  Created by Anderson on 10/18/26.
//

import SwiftUI

struct SelectorNivelMatch : View {
    var IdMinijuego : Int
    @State private var nivelesList : [vNivelesMatch] = []
    @State private var errorMsg: String?
    var body: some View {
        NavigationView () {
            VStack {
                Text("Completa niveles hasta ser un experto conociendo y relacionando figuras")
                if let errorMsg = errorMsg {
                    Text("Error: \(errorMsg)").foregroundColor(.red)
                } else if nivelesList.isEmpty {
                    ProgressView("Cargando niveles...")
                } else {
                    List(nivelesList) { nivel in
                        NavigationLink(destination: ParejasView(idNivel: nivel.id_nivel, numeroNivel: nivel.numero_nivel)) {
                            NivelesMatchShadow(niveles: nivel)
                        }
                    }
                    .listStyle(.plain)
                }
            }.background(
                Image("fondo1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.2)
            )
            .onAppear {
                // === AQUÍ ES DONDE INVOCAS TU FUNCIÓN ===
                APIService.shared.niveles_match_shadow(id_minijuego: IdMinijuego) { niveles, error in
                    if let niveles = niveles {
                        self.nivelesList = niveles
                    } else if let error = error {
                        self.errorMsg = error
                    }
                }
            }
        }
    }
}
