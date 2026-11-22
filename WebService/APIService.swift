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
    
    //==============================================================
    //FUNCIONES MATCH SHADOW
    //==============================================================
    
    // -- Get(Selector de niveles)
    
    func niveles_match_shadow(id_minijuego: Int,completion: @escaping([vNivelesMatch]?, String?) -> Void)
    {
        var components = URLComponents(string: "\(APIConfig.baseURL)/NivelesMatchShadow/Niveles")
            components?.queryItems = [
                URLQueryItem(name: "id_minijuego", value: String(id_minijuego))
            ]
            
            guard let url = components?.url else {
                completion(nil, "URL Invalida")
                return
            }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                DispatchQueue.main.async{
                    completion(nil, error.localizedDescription)
                }
                return
            }
            
            guard let data = data,
                  let niveles_match = try? JSONDecoder().decode([vNivelesMatch].self, from: data)
            else{
                DispatchQueue.main.async {
                    completion(nil, "Error al decodificar la respuesta del servidor")
                }
                return
            }
            
            DispatchQueue.main.async{
                completion (niveles_match, nil)
            }
        }.resume()
    }
    
    // -- Get (Cargar elementos del nivel de MatchShadow)
    
    func detalles_niveles_match_shadow(id_nivel: Int,numero_nivel : Int ,completion: @escaping([vDetallesNivelesMatch]?, String?) -> Void)
    {
        var components = URLComponents(string: "\(APIConfig.baseURL)/NivelesMatchShadow/Detalles")
            components?.queryItems = [
                URLQueryItem(name: "id_nivel", value: String(id_nivel)),
                URLQueryItem(name: "numero_nivel", value: String(numero_nivel))
            ]
            
            guard let url = components?.url else {
                completion(nil, "URL Invalida")
                return
            }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                DispatchQueue.main.async{
                    completion(nil, error.localizedDescription)
                }
                return
            }
            
            guard let data = data,
                  let detalles_match = try? JSONDecoder().decode([vDetallesNivelesMatch].self, from: data)
            else{
                DispatchQueue.main.async {
                    completion(nil, "Error al decodificar la respuesta del servidor")
                }
                return
            }
            
            DispatchQueue.main.async{
                completion (detalles_match, nil)
            }
        }.resume()
    }
}
