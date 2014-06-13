//
//  PlaceModel.swift
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 6/11/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

import Foundation

class PlaceModel: ModelBase, ModelProtocol {
    var location: (latitude: Double, longitude: Double)?
    var name: String?
    var questionOids: ObjectId[]?
    
    var questions: QuestionModel[]? {
    get {
        return questionOids?.map({ modelsCache[$0] as QuestionModel })
    }
    }
    
    init(oid: ObjectId?) {
        super.init(oid: oid, modelPath: "place")
    }
    
    func load(callback: EmptyCallback, fields: String[] = ["location", "name"], forceFetch: Bool = false) {
        var fieldsToQuery = String[]()
        
        if (!location || forceFetch) && fields.filter({ $0 == "location" }).count > 0 {
            fieldsToQuery.append("location")
        } else if (!name || forceFetch) && fields.filter({ $0 == "name" }).count > 0 {
            fieldsToQuery.append("name")
        } else if (!questionOids || forceFetch) && fields.filter({ $0 == "questions" }).count > 0 {
            fieldsToQuery.append("questions")
        }
        if fieldsToQuery.isEmpty {
            callback()
        } else {
            super.load({
                for (key, value: AnyObject) in $0 {
                    switch key {
                    case "location":
                        if (value as? AnyDict)?["type"] as? String == "Point" {
                            let coords = (value as? AnyDict)?["coordinates"] as Double[]
                            self.location = (latitude: coords[1], longitude: coords[0])
                        }
                    case "name":
                        self.name = value as? String
                    case "questions":
                        self.questionOids = value as? ObjectId[]
                        if let questionOids = self.questionOids {
                            for questionOid in questionOids {
                                ModelBase.createModel(questionOid, modelPath: "question")
                            }
                        }
                    default:
                        ()
                    }
                }
                callback()
            }, fields: fields)
        }
    }
    
    func save(callback: EmptyCallback) {
        var data: AnyDict = [:]
        if let location = location {
            data["location"] = ["type": "Point", "coordinates": [location.longitude, location.latitude]] as AnyDict
        }
        if let name = name {
            data["timestamp"] = name
        }
        if let questionOids = questionOids {
            data["questionOids"] = questionOids
        }
        if data.count == 0 {
            callback()
        } else {
            super.save(data, callback)
        }
    }
}