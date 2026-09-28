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
    @State private var mensajeError = ""
    @State private var cargando = false
    @State private var mostrarPassword = false
    @State private var usuarioLogueado: vConsultarUsuarios? = nil

    @FocusState private var campoActivo: Campo?

    enum Campo {
        case correo
        case contrasena
    }

    var body: some View {
        ZStack {
            // Fondo personalizado
            GeometryReader { geo in
                Image("fondo1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width,
                           height: geo.size.height)
                    .clipped()
                    .overlay(Color.black.opacity(0.48))
                    
            }
            .ignoresSafeArea() //se bajo este ignoresafearea estaba en fondo personalizado por que ponia un espacio en gris
            // Contenido principal
            ScrollView {
                VStack(spacing: 0) {

                    Spacer(minLength: 35)

                    // Logo
                    Image("Figura1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 95, height: 95)
                        .clipShape(Circle())
                        .padding(12)
                        .background(.white.opacity(0.15))
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(.white.opacity(0.35), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.2),
                                radius: 15, y: 8)

                    // Encabezado
                    Text("¡Bienvenido!")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 22)

                    Text("Inicia sesión para continuar")
                        .font(.system(size: 15))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 7)
                        .padding(.bottom, 30)

                    // Tarjeta de inicio de sesión
                    VStack(alignment: .leading, spacing: 20) {

                        Text("Iniciar sesión")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.primary)

                        Text("Ingresa tus credenciales")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .padding(.top, -14)

                        // Campo correo
                        VStack(alignment: .leading, spacing: 9) {
                            Text("Correo electrónico")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.primary)

                            HStack(spacing: 12) {
                                Image(systemName: "envelope")
                                    .foregroundColor(.blue)
                                    .frame(width: 22)

                                TextField("ejemplo@correo.com",
                                          text: $email)
                                    .keyboardType(.emailAddress)
                                    .textContentType(.emailAddress)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .focused($campoActivo, equals: .correo)
                                    .submitLabel(.next)
                                    .onSubmit {
                                        campoActivo = .contrasena
                                    }
                            }
                            .padding(15)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 13))
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(
                                        campoActivo == .correo
                                        ? Color.blue
                                        : Color.clear,
                                        lineWidth: 1.5
                                    )
                            )
                        }

                        // Campo contraseña
                        VStack(alignment: .leading, spacing: 9) {
                            Text("Contraseña")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.primary)

                            HStack(spacing: 12) {
                                Image(systemName: "lock")
                                    .foregroundColor(.blue)
                                    .frame(width: 22)

                                Group {
                                    if mostrarPassword {
                                        TextField("Ingresa tu contraseña",
                                                  text: $password)
                                    } else {
                                        SecureField("Ingresa tu contraseña",
                                                    text: $password)
                                    }
                                }
                                .textContentType(.password)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .focused($campoActivo,
                                         equals: .contrasena)
                                .submitLabel(.go)
                                .onSubmit {
                                    ejecutarLogin()
                                }

                                Button {
                                    mostrarPassword.toggle()
                                } label: {
                                    Image(systemName:
                                        mostrarPassword
                                        ? "eye.slash"
                                        : "eye")
                                        .foregroundColor(.secondary)
                                }
                                .buttonStyle(.plain)
                                .accessibilityLabel(
                                    mostrarPassword
                                    ? "Ocultar contraseña"
                                    : "Mostrar contraseña"
                                )
                            }
                            .padding(15)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 13))
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(
                                        campoActivo == .contrasena
                                        ? Color.blue
                                        : Color.clear,
                                        lineWidth: 1.5
                                    )
                            )
                        }

                        // Mensaje de error
                        if !mensajeError.isEmpty {
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "exclamationmark.circle.fill")
                                Text(mensajeError)
                                    .fixedSize(
                                        horizontal: false,
                                        vertical: true
                                    )
                            }
                            .font(.system(size: 13))
                            .foregroundColor(.red)
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.red.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }

                        // Botón de acceso
                        Button {
                            campoActivo = nil
                            ejecutarLogin()
                        } label: {
                            HStack(spacing: 10) {
                                if cargando {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Text("Iniciar sesión")
                                        .fontWeight(.bold)

                                    Image(systemName: "arrow.right")
                                        .fontWeight(.semibold)
                                }
                            }
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color.blue,
                                        Color(red: 0.20,
                                              green: 0.35,
                                              blue: 0.85)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(color: .blue.opacity(0.25),
                                    radius: 8, y: 5)
                        }
                        .disabled(cargando)
                        .opacity(cargando ? 0.7 : 1)
                        .padding(.top, 5)

                        // Bienvenida después del login
                        if let usuario = usuarioLogueado {
                            VStack(spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.green)

                                Text("¡Bienvenido, \(usuario.nombre) \(usuario.apellido)!")
                                    .font(.system(size: 16,
                                                  weight: .semibold))
                                    .foregroundColor(.green)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.green.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding(25)
                    .background(.regularMaterial)
                    .background(Color(.systemBackground).opacity(0.92))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.white.opacity(0.25),
                                    lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.2),
                            radius: 25, y: 12)
                    .padding(.horizontal, 22)

                    // Pie de página
                    Text("APP Geometría")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 25)
                        .padding(.bottom, 25)

                    Spacer(minLength: 20)
                }
                .frame(maxWidth: 480)
                .frame(maxWidth: .infinity)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .preferredColorScheme(.light)
    }

    // MARK: - Autenticación

    private func ejecutarLogin() {
        let correo = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !correo.isEmpty, !password.isEmpty else {
            mensajeError = "Completa todos los campos."
            return
        }

        guard correo.contains("@"),
              correo.contains(".") else {
            mensajeError = "Ingresa un correo electrónico válido."
            return
        }

        guard !cargando else { return }

        cargando = true
        mensajeError = ""
        usuarioLogueado = nil

        let dto = dtoValidarUsuario(
            login: correo,
            password: password
        )

        APIService.shared.validarUsuario(dto: dto) {
            usuario, error in

            DispatchQueue.main.async {
                cargando = false

                if let error = error {
                    mensajeError = error
                } else if let usuario = usuario {
                    usuarioLogueado = usuario
                } else {
                    mensajeError = "No se pudo iniciar sesión."
                }
            }
        }
    }
}

#Preview {
    Login()
}
