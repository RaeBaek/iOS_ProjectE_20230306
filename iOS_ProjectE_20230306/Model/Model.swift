//
//  Model.swift
//  iOS_ProjectE_20230306
//
//  Created by 백래훈 on 2023/03/06.
//

import Foundation

struct MovieInfo: Codable {
    
    let orderType: Int
    let movies: [Movies]
    
    enum CodingKeys: String, CodingKey {
        case orderType = "order_type"
        case movies
    }
}

struct Movies: Codable {
    let grade: Int
    let thumb: String
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: String
    let id: String
    
    var fullMovieInfo: String {
        return "평점 : \(self.userRating) 예매순위 : \(self.reservationGrade) 예매율 : \(self.reservationRate)"
    }
    
    var fullReleaseDate: String {
        return "개봉일 : \(self.date)"
    }
    
    enum CodingKeys: String, CodingKey {
        case grade, thumb, title, date, id
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
}
