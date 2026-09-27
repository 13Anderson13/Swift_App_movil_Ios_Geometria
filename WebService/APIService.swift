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

    //==============================================================
    //FUNCIONES USUARIO
    //==============================================================
    
    // -- POST (Validar Usuario)
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
    
    //==============================================================
    //FUNCIONES MINIJUEGOS
    //==============================================================
    
    // -- GET (Consultar el menu de minijuegos)
    func menu(completion: @escaping ([vConsultarMinijuego]?, String?) -> Void)
    {
        guard let url = URL(string: "\(APIConfig.baseURL)/Minijuego/Menu") 
        else {
            completion(nil,"URL Invalida")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("aplication/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                DispatchQueue.main.async{
                    completion(nil, error.localizedDescription)
                }
                return
            }
            
            guard let data = data,
                  let minijuegos = try? JSONDecoder().decode([vConsultarMinijuego].self, from: data)
            else{
                DispatchQueue.main.async {
                    completion(nil, "Error al decodificar la respuesta del servidor")
                }
                return
            }
            
            DispatchQueue.main.async{
                completion (minijuegos, nil)
            }
        }.resume()
    }
}
