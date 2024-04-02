//
//  NetworkFactory.swift
//  Poke-Card
//
//  Created by NurFajar, Isa | INPD on 2024/03/31.
//

import Foundation

enum NetworkFactory {
    //MARK: - POKEMON
    case getPokemon(name: String)
    
    case getAbility(name: String)
    
}

extension NetworkFactory {
    // MARK: URL PATH API
    var path: String {
        switch self {
        case .getPokemon(let name):
            return "pokemon/\(name)"
        case .getAbility(let name):
            return "ability/\(name)"
        }
    }
    
    // MARK: URL QUERY PARAMS / URL PARAMS
    var queryItems: [URLQueryItem] {
        switch self {
        case .getPokemon, .getAbility:
            return []
        }
    }
    
    var bodyParam: [String: Any]? {
        switch self {
        case .getPokemon, .getAbility:
            return [:]
        }
    }
    
    // MARK: BASE URL API
    var baseApi: String? {
        switch self {
        case .getPokemon:
            return "https://pokeapi.co/api/v2/"
        case .getAbility:
            return "https://pokeapi.co/api/v3/"
        }
    }
    
    // MARK: URL LINK
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseApi
        let finalParams: [URLQueryItem] = self.queryItems
        components.path = path
        components.queryItems = finalParams
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    // MARK: HTTP METHOD
    var method: RequestMethod {
        switch self {
        case .getPokemon, .getAbility:
            return .get
        }
    }
    
    enum RequestMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }
    
    var boundary: String {
//        let boundary: String = "Boundary-\(UserDefaults.deviceFCMToken)"
        return "boundary"
    }
    
    // MARK: MULTIPART DATA
    var data: [(paramName: String, fileData: Data, fileName: String)]? {
        switch self {
        default:
            return nil
        }
    }
    
    // MARK: HEADER API
    var headers: [String: String]? {
        switch self {
        case .getPokemon, .getAbility:
            return getHeaders(type: .authorized)
        }
    }
    
    enum HeaderType {
        case anonymous
        case authorized
        case appToken
        case multiPart
        case authorizedMultipart
    }
    
    fileprivate func getHeaders(type: HeaderType) -> [String: String] {
        
        let _ = UserDefaults.standard.string(forKey: "UserToken")
        
        var header: [String: String]
        
        switch type {
        case .anonymous:
            header = [:]
        case .authorized:
            header = ["Content-Type": "application/json",
                      "Accept": "*/*",
                      "Authorization": "Basic \(setupBasicAuth())"]
            
        case .authorizedMultipart:
            header = ["Content-Type": "multipart/form-data; boundary=\(boundary)",
                      "Accept": "*/*",
                      "Authorization": "Basic \(setupBasicAuth())"]
        case .appToken:
            header = ["Content-Type": "application/json",
                      "Accept": "*/*"]
        case .multiPart:
            header = ["Content-Type": "multipart/form-data; boundary=\(boundary)",
                      "Accept": "*/*"]
        }
        return header
    }
    
    func createBodyWithParameters(parameters: [String: Any], imageDataKey: [(paramName: String, fileData: Data, fileName: String)]?, boundary: String) throws -> Data {
        let body = NSMutableData()
        
        for (key, value) in parameters {
            body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)".data(using: .utf8)!)
        }
        
        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        
        if let imageData = imageDataKey {
            for datum in imageData {
                if datum.fileData != Data() {
                    body.append("Content-Disposition: form-data; name=\"\(datum.paramName)\"; filename=\"\(datum.fileName)\"\r\n".data(using: .utf8)!)
//                    body.append("Content-Type: \(datum.fileData.mimeType)\r\n\r\n".data(using: .utf8)!)
                    body.append(datum.fileData)
                    body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
                }
            }
        }
        
        return body as Data
    }
    
    private func setupBasicAuth() -> String {
//        let username = ConfigManager.shared.getValue(forKey: .userToken)
//        let password = ConfigManager.shared.getValue(forKey: .passToken)
//        let loginString = "\(username):\(password)"
        let loginString = ""
        
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return ""
        }
        let _ = loginData.base64EncodedString()
        
        //        return base64LoginString
        return "bmFuYS5udXJ3YW5kYUBnbWFpbC5jb206a2VyamErc2pzKzIwMjE="
    }
    
    var urlRequestMultiPart: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = method.rawValue
        let boundary = boundary
        if let header = headers {
            header.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam = bodyParam, let datas = data {
            urlRequest.httpBody = try? createBodyWithParameters(parameters: bodyParam, imageDataKey: datas, boundary: boundary) as Data
        }
        
        return urlRequest
    }
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url, timeoutInterval: 10.0)
        var bodyData: Data?
        urlRequest.httpMethod = method.rawValue
        if let header = headers {
            header.forEach { (key, value) in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam = bodyParam, method != .get {
            do {
                bodyData = try JSONSerialization.data(withJSONObject: bodyParam, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            } catch {
                // swiftlint:disable disable_print
#if DEBUG
                print(error)
#endif
                // swiftlint:enable disable_print
            }
        }
        return urlRequest
    }
}
