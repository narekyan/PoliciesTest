//
//  NetworkFeature.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

class NetworkFeature {
    
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }

    func get<T: Decodable>(_ url: String, completion: @escaping (T?, _ errorMessage: String?) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(nil, nil)
            return
        }
        session.dataTask(with: url, completionHandler: { (data, urlReponse, error) in
            var errorMessage: String?
            var response: T?
            defer {
                completion(response, errorMessage)
            }
            guard let data = data, (200..<300).contains((urlReponse as? HTTPURLResponse)?.statusCode ?? 0) else {
                errorMessage = error?.localizedDescription
                return
            }
            do  {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                response = try decoder.decode(T.self, from: data)
            
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("### Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("*** Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
                errorMessage = error.localizedDescription
            }
        }).resume()
    }
}
