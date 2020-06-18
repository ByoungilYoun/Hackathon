//
//  Constants.swift
//  CardGame
//
//  Created by 윤병일 on 2020/06/04.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//
// Onboarding 에 나타낼 글씨들
import Foundation
import Firebase


let MSG_CARDGAME = "카드 맞추기 게임"
let MSG_MEMORY = "기억력 테스트"
let MSG_RANKING = "랭킹"

let MSG_ONBOARDING_CARDGAME = "서로 같은 그림의 카드를 맞춰보세요!"
let MSG_ONBOARDING_MEMORY = "게임을 통해 기억력 테스트 및 기억력 향상에 도움!"
let MSG_ONBOARDING_RANKING = "가장 높은 점수를 획득해보세요!"

let MSG_RESET_PASSWORD_LINK_SENT = "해당 이메일로 초기화 링크를 보내드렸습니다."

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")


