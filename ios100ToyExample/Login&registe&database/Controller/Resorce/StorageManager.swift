//
//  StorageManager.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/02.
//

import Foundation
import FirebaseStorage
//스토리지를 관리 할것 입니다.
final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    
    //데이터를 받아오고 파일 이름(명명구조 표준화)을 저장하는 함수를 추가하겠습니다. / 문자열 타입으로 URL을 다운로드 할 것 입니다.
    /* 명명 구조
     /images/이메일-naver-com_profile_picture.png
     */
    ///사진을 파이어베이스 저장소에 업로드하고 다운로드할 URL문자열과 함께 완료를 반환 합니다.
    public func uploadProfilePicture(with data: Data, fileName: String, complation: @escaping (Result<String, Error>) -> Void) {
        storage.child("images/\(fileName)").putData(data,metadata: nil,completion: { metadata, error in
            guard error == nil else {
                print("Database - 26 파이어베이스에 사진을 업로드 하는 것을 실패 했습니다.")
                complation(.failure(StorageErrors.faildToUpload))
                return
            }
            self.storage.child("images/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("Database - 32 URL을 다운로드 하지 못했습니다.")
                    complation(.failure(StorageErrors.faildToGetDownloadURL))
                    return
                }
                let urlString = url.absoluteString
                print("URL을 다운로드 하는것에 성공 했습니다.")
                complation(.success(urlString))
            })
        })
    }
    
    //오류를 정의 하겠습니다.
    public enum StorageErrors: Error {
        case faildToUpload
        case faildToGetDownloadURL
    }
    
    
}
