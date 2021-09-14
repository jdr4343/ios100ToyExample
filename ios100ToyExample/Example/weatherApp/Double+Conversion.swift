//
//  Double+Conversion.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/14.
//

import Foundation

extension Double {
    //받아온 켈빈 값을 섭씨로 컨버젼 해줍니다.
    var kelvinToCelsius: Double {
        return self - 273.15
    }
}
