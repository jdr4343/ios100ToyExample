//
//  NetworkController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/14.
//

///아래의 url를 쿼리 합니다.
///http://api.openweathermap.org/data/2.5/weather?id=1835848&appid={API key}

import Foundation

struct NetworkController {
    
    private static var baseUrl = "api.openweathermap.org"
    private static let apiKey = "f5220d65cf537cfb942a8920b1829833"
    
    enum Endpoind {
        //도시를 식별합니다.
        case cityId(path: String = "/data/2.5/weather", id: Int)
        
        var url: URL? {
            var components = URLComponents()
            //URL의 구성 요소 추가
            components.scheme = "https"
            components.host = baseUrl
            components.path = path
            components.queryItems = qureyItems
            return components.url
        }
        
        private var path: String {
            switch self {
            case .cityId(let path, _):
                return path
            }
        }
        
        private var qureyItems: [URLQueryItem] {
            
            //api키 추가할 쿼리 배열을 만듭니다.
            var qureyItems = [URLQueryItem]()
            
            switch self {
            case .cityId(_, let id):
                qureyItems.append(URLQueryItem(name: "id", value: String(id)))
            }
            
            qureyItems.append(URLQueryItem(name: "appid", value: apiKey))
            return qureyItems
        }
    }
    
    //1835848는 서울의 id입니다. 웹에서 다운받아서 본인의 도시로 설정 해보세유!
    static func fetchWeather(for cityId: Int = 1835848, completion: @escaping ((Weather) -> Void)) {
        if let url = Endpoind.cityId(id: cityId).url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("날씨 앱에서 에러가 발생했습니다. - \(error)")
                }
                
                if let data = data  {
                    do {
                        let weather = try JSONDecoder().decode(Weather.self, from: data)
                        completion(weather)
                    } catch let error {
                        print("데이터를 디코딩 하는것에 실패 했습니다. - \(error)")
                    }
                }
            }
            //URLSession = .resume()  ⭐️⭐️⭐️⭐️⭐️
            .resume()
        }
    }
    
}
