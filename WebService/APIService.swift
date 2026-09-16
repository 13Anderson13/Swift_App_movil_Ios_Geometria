//
//  APIService.swift
//  APPGeometria
//
//  Created by Macbook Pro 2015 on 9/15/26.
//
import Foundation

class APIService {
    static let shared = APIService()
    private init() {}

    func validarUsuario(dto: dtoValidarUsuario, completion: @escaping (vConsultarUsuarios?, String?) -> Void) {
        guard let url = URL(string: "\(APIConfig.baseURL)/Usuario/Logear") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(dto)

        URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data,
                  let usuario = try? JSONDecoder()
                .decode(vConsultarUsuarios.self, from: data) else {
                completion(nil, "Usuario o contraseña incorrectos")
                return
            }
            completion(usuario, nil)
        }.resume()
    }
}
