//
//  CommentModel.swift
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 6/11/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

import Foundation

class CommentModel: ModelBase, ModelProtocol {
    var text: String?
    var timestamp: NSDate?
    var activityOids: ObjectId[]?
    var questionOid: ObjectId?
    var userOid: ObjectId?
    
    var activities: ActivityModel[]? {
    get {
        return activityOids?.map({ modelsCache[$0] as ActivityModel })
    }
    }
    
    var question: QuestionModel? {
    get {
        return modelsCache[questionOid!] as? QuestionModel
    }
    }
    
    var user: UserModel? {
    get {
        return userOid ? modelsCache[userOid!] as? UserModel : nil
    }
    }
    
    init(oid: ObjectId?) {
        super.init(oid: oid, modelPath: "comment")
    }
    
    func load(callback: EmptyCallback, fields: String[] = ["text", "timestamp", "question", "user"], forceFetch: Bool = false) {
        var fieldsToQuery = String[]()
        
        if (!text || forceFetch) && fields.filter({ $0 == "text" }).count > 0 {
            fieldsToQuery.append("text")
        } else if (!timestamp || forceFetch) && fields.filter({ $0 == "timestamp" }).count > 0 {
            fieldsToQuery.append("timestamp")
        } else if (!activityOids || forceFetch) && fields.filter({ $0 == "activities" }).count > 0 {
            fieldsToQuery.append("activities")
        } else if (!questionOid || forceFetch) && fields.filter({ $0 == "question" }).count > 0 {
            fieldsToQuery.append("question")
        } else if (!userOid || forceFetch) && fields.filter({ $0 == "user" }).count > 0 {
            fieldsToQuery.append("user")
        }
        
        if fieldsToQuery.isEmpty {
            callback()
        } else {
            super.load({
                for (key, value: AnyObject) in $0 {
                    switch key {
                    case "text":
                        self.text = value as? String
                    case "timestamp":
                        self.timestamp = NSDate(timeIntervalSince1970: value as NSTimeInterval)
                    case "activities":
                        self.activityOids = value as? ObjectId[]
                        if let activityOids = self.activityOids {
                            for activityOid in activityOids {
                                ModelBase.createModel(activityOid, modelPath: "activity")
                            }
                        }
                    case "question":
                        self.questionOid = value as? ObjectId
                        ModelBase.createModel(self.questionOid, modelPath: "question")
                    case "user":
                        self.userOid = value as? ObjectId
                        ModelBase.createModel(self.userOid, modelPath: "user")
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
        if let text = text {
            data["text"] = text
        }
        if let timestamp = timestamp {
            data["timestamp"] = timestamp.timeIntervalSince1970
        }
        if let activityOids = activityOids {
            data["activityOids"] = activityOids
        }
        if let questionOid = questionOid {
            data["questionOid"] = questionOid
        }
        if let userOid = userOid {
            data["userOid"] = userOid
        }
        if data.count == 0 {
            callback()
        } else {
            super.save(data, callback)
        }
    }
}