//
//  Login.swift
//  APPGeometria
//
//  Created by Macbook Pro 2015 on 9/7/26.
//

import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State private var mensajeError = "" //Mensaje ue veremos en caso de que la peticion falle
    @State private var cargando = false //Variable que funciona como loader del boton continuar
    @State private var usuarioLogueado: vConsultarUsuarios? = nil //La usamos para guardar el mapeo que regresa del sp

    var body: some View {
        VStack {
            //Figura utilizada para el icono de inicio
            Image("Figura1")
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .shadow(radius: 50)

            VStack(alignment: .leading) {
                Group {
                    Text("Correo")
                    HStack {
                        Image(systemName: "envelope.fill")
                        TextField("Correo", text: $email)
                            .autocapitalization(.none)
                    }

                    Text("Contraseña")
                    HStack {
                        Image(systemName: "square.and.pencil")
                        SecureField("Contraseña", text: $password)
                    }
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .font(.caption)
            }

            // Boton para accionar la peticion
            Button(action: {
                ejecutarLogin()
            })
            {
                if cargando {
                    ProgressView()
                } else {
                    Text("Iniciar Sesión")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .disabled(cargando)

            // Error en caos de se active algun problema
            if !mensajeError.isEmpty {
                Text(mensajeError)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 5)
            }

            // Bienvenida de prueba mientras se generan mas ventanas
            if let usuario = usuarioLogueado {
                Text("¡Bienvenido, \(usuario.nombre) \(usuario.apellido)!")
                    .foregroundColor(.green)
                    .bold()
                    .padding(.top, 10)
            }
        }
        .background(
            Image("fondo")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.2)
        )
    }

    // Funcion que invoca el servicio que vamos autilizar
    private func ejecutarLogin() {
        guard !email.isEmpty, !password.isEmpty else {
            mensajeError = "Completa todos los campos"
            return
        }
        cargando = true
        mensajeError = ""

        let dto = dtoValidarUsuario(login: email, password: password)

        APIService.shared.validarUsuario(dto: dto) { usuario, error in
            cargando = false
            if let error = error {
                self.mensajeError = error
            } else if let usuario = usuario {
                self.usuarioLogueado = usuario
            }
        }
    }
}

#Preview {
    Login()
}
