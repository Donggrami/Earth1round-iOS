//
//  HTTPMethodURL.swift
//  Earth1round-iOS
//
//  Created by kong on 2022/08/12.
//

import Foundation

enum HTTPMethodURL {
    
    struct GET {
        static let myPage = "/profiles/mypage" // 유저 정보 조회 (마이 페이지)
        static let myCharater = "/profiles/room" //
        static let places = "/places" // 장소 리스트 조회
        static let course = "/course" // 현재 코스 조회
        static let courseList = "/courses" // 코스 리스트 조회 (나의 기록)
        static let custom = "/custom" // 캐릭터 커스텀 번호 조회
    }
    
    struct POST {
        static let kakaoLogin = "/login/kakao"
        static let reissue = "/re-issue"
        static let course = "/courses" // 코스 저장
    }
    
    struct PATCH {
        static let nickname = "/profiles/nickname" // 닉네임 수정
        static let course = "/course" // 현재 코스 완료
        static let custom = "/custom" // 캐릭터 커스텀 번호 수정
    }
    
    struct PUT {
        
    }
    
    struct DELETE {
        
    }
    
}
