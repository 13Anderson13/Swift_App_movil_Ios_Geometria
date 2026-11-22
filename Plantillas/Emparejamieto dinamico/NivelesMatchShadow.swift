//
//  NivelesMatchShadow.swift
//  APPGeometria
//
//  Created by Anderson on 10/18/26.
//

import SwiftUI

struct NivelesMatchShadow : View {
    var niveles : vNivelesMatch?
    var body: some View {
        Button {
            print("Hola mundo")
        }label : {
            VStack
            {
                HStack{
                    ZStack{
                        Circle()
                            .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.98, green: 0.2, blue: 0.45),
                                    Color(red: 0.95, green: 0.35, blue: 0.15),
                                    Color(red: 0.99, green: 0.6, blue: 0.15)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                            .frame(width: 60, height: 60)
                        Text("\(String(niveles?.numero_nivel ?? 0))")
                            .foregroundColor(.white)
                            .bold()
                    }
                    VStack(alignment : .leading)
                    {
                        Text("\(niveles?.titulo_nivel ?? "Titulo de minijuego")")
                            .font(.headline)
                            .foregroundColor(Color.black)
                            .bold()
                        HStack{
                            Text("Dificultad : ")
                                .foregroundColor(.black)
                            ForEach(0..<5)
                            {
                                i in
                                if(i<(niveles?.dificultad ?? 0))
                                {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }else{
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                
                        }
                        HStack{
                            Text("Estado: ")
                                .foregroundColor(.black)
                            if(niveles?.estado == true)
                            {
                                Text("Compleado")
                                    .foregroundColor(.black)
                            }else{
                                Text("Incompleto")
                                    .foregroundColor(.black)
                            }
                            
                        }
                    }
                    
                    Spacer()
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width : 25, height: 30)
                        .foregroundColor(Color.green)
                }
            }
        }.padding()
    }
}

#Preview{
    NivelesMatchShadow(niveles: vNivelesMatch(
        id_nivel: 1,
        numero_nivel: 1,
        id_minijuego: 1,
        titulo_nivel: "Nivel 1: Básicos",
        dificultad: 2,
        estado: true
    ))
}
