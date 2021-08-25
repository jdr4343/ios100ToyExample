//
//  ApiCaller.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/08/19.
//

import Foundation



//api는 newsapi.org에서 받아 올수 있습니다. 받아온 api를 복사하여 APICaller에 저장해주시면 됩니다.
//finer로 선언하면 이클래스는 더 이상 참조 할수 없습니다.
final class APICaller {
    static let shared = APICaller()

    struct Constants {
        static let WallStreetURL = URL(string: "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=d60933c3b09140c890209cff548884d6")
        static let searchURlString =
            "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=d60933c3b09140c890209cff548884d6&q="
    }

    
    private init() {}
    
    //@escapin은 비동기 처리를 사용할때 사용하는 방법입니다. 동기와 비동기에 대한 설명은 짧게 나마 spinner에서 했습니다!
    //함수는 연산을 시작시키고 반환 하지만 escaping Closer는 연산이 완료 될떄까지 호출되지 않습니다. 나중에 호출하기 위해선 클로저를 벗어나야합니다!
    public func getTopStories(complation: @escaping(Result<[Article], Error>) -> Void) {
        //url은 옵셔널 값이기 때문에 바인딩 해주어야 합니다.
        guard let url = Constants.WallStreetURL else {
            print("url faield..🙉")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complation(.failure(error))
            } else if let data = data {
                //do catch 블럭은 에러를 처리 할떄 사용합니다. 에러가 do 블럭에서 발생한다면 발생하는 에러의 종류를 catch 구문으로 구분해 처리합니다. /json 디코더를 사용하여 원하는 데이터의 정보를 디코딩 합니다. / 디코딩이란 쉽게 말하면 압축을 풀어 내는 것 입니다.
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    complation(.success(result.articles))
                }
                catch {
                    complation(.failure(error))
                }
            }
        }
        task.resume() //머부분의 에러중에 한부분인 resume입니다.. 잊지말고 사용해주세요! 🔥
    }
    
    public func search(with query: String, complation: @escaping(Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlString = Constants.searchURlString + query
        guard let url = URL(string: urlString) else {
            print("url faield..🙉")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complation(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    complation(.success(result.articles))
                }
                catch {
                    complation(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}

