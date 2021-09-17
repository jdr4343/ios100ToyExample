//
//  NatworkManager.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/18.
//

import Foundation

//에러정의
enum NetworkManagerError: Error {
  case badResponse(URLResponse?)
  case badData
  case badLocalUrl
}
fileprivate struct ApiResponse: Codable {
  let results: [Post]
}

///https://unsplash.com/oauth/applications/261471
//사진에 대한 초기 HTTP 요청을 수행하도록 코드를 작성합니다.
let accessKey = "vqlzcwqDw1vROIgXqx172wuJVgsoiTe-_GcPY3MLf3A"


class NetworkManger {
    static var shared = NetworkManger()
   
    let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    private func components() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        return components
    }
    /*
     Authorization: Client-ID YOUR_ACCESS_KEY
     https://api.unsplash.com/photos/?client_id=YOUR_ACCESS_KEY
     GET /search/photos
    */
    private func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func posts(query: String, completion: @escaping ([Post]?, Error?) -> (Void)) {
        var comp = components()
        comp.path = "/search/photos"
        comp.queryItems = [
        URLQueryItem(name: "query", value: query)
        ]
        //프로토콜 또는 URL 구성표가 없는 URL 로드 요청을 할떄 URLRequest 사용합니다.
        let req = request(url: comp.url!)
        
        let task = session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            //오류를 확인하고 HTTP응답이 200 ~ 299 범위 내에 있는지 확인 한다음 데이터가 실제로 존재하는지 확인합니다.
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkManagerError.badResponse(response))
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkManagerError.badData)
                return
            }
            //받아온 데이터를 디코딩 하고 프로토콜을 사용하여 작업을 수행합니다.
            do {
                let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                completion(response.results, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
//    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> (Void)) {
//        if let imageData = images.ob
//    }
    
}
