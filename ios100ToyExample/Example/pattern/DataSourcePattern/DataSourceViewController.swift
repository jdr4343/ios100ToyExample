//
//  DataSourceViewController.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/18.
//

import UIKit

struct ImageInfo: Codable {
    let title: String
    let thumbnailUrl: String
}


class DataSourceViewController: UIViewController, ImageInfoViewDataSource {
   
    private let infoView = ImageInfoView()
    
    private var model: ImageInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(infoView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .white
        
        infoView.frame = CGRect(x: 0, y: 0, width: view.width-20, height: view.width-20)
        infoView.center = view.center
        infoView.datasource = self
        fetchData()
    }
   
    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos/1") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(ImageInfo.self, from: data)
                self?.model = result
                DispatchQueue.main.async {
                    self?.infoView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //MARK: DataSource
    
    func imageInfoViewTitleForImage(_ imageView: ImageInfoView) -> String? {
        return model?.title
    }
    
    func imageInfoViewURLForImage(_ imageView: ImageInfoView) -> URL? {
        return URL(string: model?.thumbnailUrl ?? "")
    }
}

