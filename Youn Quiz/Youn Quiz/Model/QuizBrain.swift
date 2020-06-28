//
//  QuizBrain.swift
//  Youn Quiz
//
//  Created by 윤병일 on 2020/06/28.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation

struct QuizBrain {
  
  var questionNumber = 0
  var score = 0
  
  let quiz : [Question] = [
    Question(q: "윤병일(나) 은/는 남자다.", a: "True"),
    Question(q: "나의 고향은 전주다.", a: "False"),
    Question(q: "나는 강아지 보다 고양이를 더 좋아한다." , a: "False"),
    Question(q: "나는 면종류 음식을 좋아한다.", a: "True"),
    Question(q: "나는 아이유를 좋아한다.", a: "True"),
    Question(q: "나는 애플 제품을 4개 이상 가지고 있다.", a: "True"),
    Question(q: "나는 서울대를 나왔다.", a: "False")
  ]
  
 mutating func checkAnswer(_ answer : String) -> Bool {
    if answer == quiz[questionNumber].answer {
      score += 1
      return true
    } else {
      return false 
    }
  }
  
  func getQuestion() -> String {
    return quiz[questionNumber].text
  }
  
  func getProgress() -> Float {
    let progress = Float(questionNumber) / Float(quiz.count)
    return progress
  }
  
  func getScore() -> Int {
    return score
  }
  
  
  mutating func nextQuestion() {
    if questionNumber + 1 < quiz.count {
      questionNumber += 1
    } else {
      questionNumber = 0
      score = 0
    }
  }
  
}
