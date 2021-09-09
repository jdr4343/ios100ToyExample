//
//  StorageManager.swift
//  ios100ToyExample
//
//  Created by 신지훈 on 2021/09/02.
//

import Foundation
import FirebaseStorage

///파이어베이스 스토리지에 파일을 업로드하고 가져올수 있습니다.
final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    
    //오류를 정의 하겠습니다.
    public enum StorageErrors: Error {
        case faildToUpload
        case failedToGetDownloadUrl
    }
    
    //데이터를 받아오고 파일 이름(명명구조 표준화)을 저장하는 함수를 추가하겠습니다. / 문자열 타입으로 URL을 다운로드 할 것 입니다.
    /* 명명 구조
     /images/이메일-naver-com_profile_picture.png
     */
    ///프로필 사진을 파이어베이스 저장소에 업로드하고 다운로드할 URL문자열과 함께 완료를 반환 합니다.
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("images/\(fileName)").putData(data,metadata: nil,completion: { [weak self] metadata, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print("파이어베이스에 사진을 업로드 하는 것을 실패 했습니다.")
                completion(.failure(StorageErrors.faildToUpload))
                return
            }
            strongSelf.storage.child("images/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print(" URL을 다운로드 하지 못했습니다.")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("URL을 다운로드 하는것에 성공 했습니다.")
                completion(.success(urlString))
            })
        })
    }
    
   /// 대화 메시지로 보낼 이미지를 저장소에 업로드하고 다운로드할 URL문자열과 함께 완료를 반환 합니다.
    public func uploadMessagePhoto(with data: Data, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("message_images/\(fileName)").putData(data,metadata: nil,completion: { [weak self] metadata, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print(" 파이어베이스에 사진을 업로드 하는 것을 실패 했습니다.")
                completion(.failure(StorageErrors.faildToUpload))
                return
            }
            strongSelf.storage.child("message_images/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("사진 URL을 다운로드 하지 못했습니다.")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("사진 URL을 다운로드 하는것에 성공 했습니다.")
                completion(.success(urlString))
            })
        })
    }
    
   /// 대화 메시지로 보낼 동영상을 저장소에 업로드하고 다운로드할 URL문자열과 함께 완료를 반환 합니다.
    public func uploadMessageVideo(with fileUrl: URL, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("message_videos/\(fileName)").putFile(from: fileUrl,metadata: nil,completion: { [weak self] metadata, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print("파이어베이스에 동영상을 업로드 하는 것을 실패 했습니다.")
                completion(.failure(StorageErrors.faildToUpload))
                return
            }
            strongSelf.storage.child("message_videos/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("동영상 URL을 다운로드 하지 못했습니다.")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("동영상 URL을 다운로드 하는것에 성공 했습니다.")
                completion(.success(urlString))
            })
        })
    }
    
    ///커버 사진을 저장소에 업로드하고 다운로드할 URL문자열과 함께 완료를 반환 합니다.
    public func uploadCoverPhoto(with data: Data, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("cover_images/\(fileName)").putData(data, metadata: nil, completion: { [weak self] metadata, error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print("파이어베이스에 커버 사진을 업로드 하는 것을 실패 하였습니다.")
                completion(.failure(StorageErrors.faildToUpload))
                return
            }
            strongSelf.storage.child("cover_images/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("커버 사진 URL을 다운로드 하지 못했습니다.")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("커버 사진을 다운로드 하는것에 성공 했습니다.")
                completion(.success(urlString))
            })
        })
    }
    
    
   
    
    ///지정한 경로를 기반으로 다운로드 URL을 반환합니다.
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                print("다운로드 실패")
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            completion(.success(url))
        })
    }
    
    
    
    
}
