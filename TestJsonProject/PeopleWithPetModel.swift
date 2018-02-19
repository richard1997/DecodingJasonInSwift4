//
//  PeopleWithPetModel.swift
//  AGLTestProject
//
//  Created by Jiaren on 18/2/18.
//  Copyright © 2018 Jiaren. All rights reserved.
//

import Foundation

struct PeopleWithPets: Decodable {
    var name: String
    var gender: String
    var age: Int
    var pets: [Pet]?
    
    struct Pet:Decodable {
        var name: String
        var type: String
    }
    
    enum CodingKeys : String, CodingKey {
        case name
        case gender
        case age
        case pets
    }
    
    init(from coder: Decoder) throws {
        let container = try coder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.age = try container.decode(Int.self, forKey: .age)
        self.pets = try container.decodeIfPresent([Pet].self, forKey: .pets)
    }
}
