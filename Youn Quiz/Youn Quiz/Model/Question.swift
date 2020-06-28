//
//  Quiz.swift
//  Youn Quiz
//
//  Created by 윤병일 on 2020/06/25.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation

struct Question {
    let text : String
    let answer : String
    
    init( q : String, a : String ) {
        text = q
        answer = a 
    }
}

