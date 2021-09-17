//
//  HomeWidzetTableViewCell.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/14.
//


import UIKit
import CoreLocation

class HomeWidzetTableViewCell: UITableViewCell, CLLocationManagerDelegate{

    static let identifier = "HomeWidzetTableViewCell"
  

    // 날씨 뷰
     var currentWeather: CurrentWeather?
    private var currentLocation: CLLocation!
    private let locationManger = CLLocationManager()
    
    //Todo뷰
    
    private let weatherView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "배경3")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 60
        return view
    }()
    private let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "sun.min.fill")
        view.tintColor = .white
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    
    //To Do 뷰
    private let todoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "배경2")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 60
        view.isUserInteractionEnabled = false
        return view
    }()
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.layer.masksToBounds = true
        return tableView
    }()
    private let todoTitleLable: UILabel = {
        let label = UILabel()
        label.text = "To Do List"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.isUserInteractionEnabled = false
        return label
    }()
    lazy var addToDoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.square.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapAddList), for: .touchUpInside)
        return button
    }()
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addWeatherView()
        //위치 정보
        locationManger.delegate = self
        setUpLoction()
        locationAuthCheck()
        //날씨 위젯
        currentWeather = CurrentWeather()
        // API데이터를 다운로드 합니다.
             currentWeather?.downloadCurrentWeather {
                 //다운로드가 완료 된후 UI를 업데이트 합니다.
                 self.updateWeaderUI()
                 print("데이터 다운로드")
             }
        
        //TodoWizet
        contentView.addSubview(todoView)
        contentView.addSubview(todoTableView)
        todoView.addSubview(todoTitleLable)
        contentView.addSubview(addToDoButton)
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.showsVerticalScrollIndicator = false
        todoTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        todoView.frame = CGRect(x: 10, y: 10, width: contentView.width/2-20, height: contentView.height-20)
        //날씨
        weatherView.frame = CGRect(x: todoView.right+15, y: 10, width: contentView.width/2-20, height: contentView.height-20)
        dateLabel.frame = CGRect(x: 10, y: 10, width: weatherView.width-20, height: 20)
        cityLabel.frame = CGRect(x: 10, y: dateLabel.bottom+10, width: weatherView.width-20, height: 20)
        temperatureLabel.frame = CGRect(x: 10, y: cityLabel.bottom+10, width: weatherView.width-20, height: 40)
        weatherImageView.frame = CGRect(x: weatherView.width/2-25, y: temperatureLabel.bottom, width: 50, height: 50)
        weatherLabel.frame = CGRect(x: 10, y: weatherImageView.bottom+30, width: weatherView.width-20, height: 20)
        
        //Todo
        todoTitleLable.frame = CGRect(x: 30, y: 10, width: todoView.width-90, height: todoView.height/8)
        addToDoButton.frame = CGRect(x: todoTitleLable.right+5, y: 21, width: 25, height: 25)
        todoTableView.frame = CGRect(x: 10, y: 50, width: todoView.width-10, height: todoView.height-50)
        
    }
   // 날씨
    private func addWeatherView() {
        //뷰
        contentView.addSubview(weatherView)
        weatherView.addSubview(weatherImageView)
        //라벨
        weatherView.addSubview(dateLabel)
        weatherView.addSubview(temperatureLabel)
        weatherView.addSubview(weatherLabel)
        weatherView.addSubview(cityLabel)
       
    }
    private func updateWeaderUI() {
        
        cityLabel.text = currentWeather?.cityName
        temperatureLabel.text = "\(Int(currentWeather?.currentTemp ?? 0.0))°C"
        weatherLabel.text = currentWeather?.weatherType
        dateLabel.text = currentWeather?.date
        
    }
    //위치 정보
    ///위치 정보 권한을 요청 합니다.
    private func setUpLoction() {
        //위치에 관한 정확도를 설정합니다.
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        //사용 승인시 위치관리자에게 좌표 요청을 할것이므로 앱이 열릴때만 GPS를 사용 하도록 하고 해당 용도로만 승인을 얻습니다.
        //api자체가 외국 api이다보니 도시정보가 좀 정확하지 않은거 같습니다. ㅜㅜ
        self.locationManger.requestWhenInUseAuthorization()
        //위치 변경사항을 모니터링 합니다.
        locationManger.startMonitoringSignificantLocationChanges()
    }
    ///위치 정보 권한이 있는지 권한이 없는지 확인합니다.사용자가 위치 권한을 허용 했을 경우 위치데이터를 API로 보낸다음 데이터를 다운로드하고 제공하지 않은경우 사용자에게 권한을 부여 합니다.
    private func locationAuthCheck() {
        print("작동중")
            switch locationManger.authorizationStatus {
            case .restricted, .denied: //권한이 없습니다. 다시 사용자에게 요청합니다.
                self.locationManger.requestWhenInUseAuthorization()
                locationAuthCheck()
                print("권한을 다시 요청합니다.")
            case .authorizedAlways, .authorizedWhenInUse:
              print("권한이 허용 됬습니다")
                
            //장치로 부터 위치를 얻습니다.
                guard let currentLocation: CLLocationCoordinate2D = locationManger.location?.coordinate else {
                    return
                }
                print("위치 정보 = 위도: \(currentLocation.latitude) 경도 \(currentLocation.longitude)")

            //위치를 API에게 전달합니다.
                WeatherLocation.shared.latitude = currentLocation.latitude
                WeatherLocation.shared.longitude = currentLocation.longitude
                print(WeatherLocation.shared.latitude!)
                

         

            default:
                break
            }
      
    }
    
    //To Do
    @objc private func didTapAddList() {
        print("작동중")
    
    }
   
}
extension HomeWidzetTableViewCell: UITableViewDelegate, UITableViewDataSource, ToDoTableViewCellDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = todoTableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier, for: indexPath) as! ToDoTableViewCell
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoTableView.deselectRow(at: indexPath, animated: true)
        print("작동중")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func didTapChackBox() {
        print("연결되었습니다.")
    }
}
