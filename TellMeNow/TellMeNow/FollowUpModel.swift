//
//  FollowUpModel.swift
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 6/11/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

import Foundation

class FollowUpModel: ModelBase, ModelProtocol {
    var text: String?
    var timestamp: NSDate?
    var activityOids: ObjectId[]?
    var answerOid: ObjectId?
    var userOid: ObjectId?
    
    var activities: ActivityModel[]? {
    get {
        return activityOids?.map({ modelsCache[$0] as ActivityModel })
    }
    }
    
    var answer: AnswerModel? {
    get {
        return modelsCache[answerOid!] as? AnswerModel
    }
    }
    
    var user: UserModel? {
    get {
        return userOid ? modelsCache[userOid!] as? UserModel : nil
    }
    }
    
    init(oid: ObjectId?) {
        super.init(oid: oid, modelPath: "followUp")
    }
    
    func load(callback: EmptyCallback, fields: String[] = ["text", "timestamp", "answer", "user"], forceFetch: Bool = false) {
        var fieldsToQuery = String[]()
        
        if (!text || forceFetch) && fields.filter({ $0 == "text" }).count > 0 {
            fieldsToQuery.append("text")
        } else if (!timestamp || forceFetch) && fields.filter({ $0 == "timestamp" }).count > 0 {
            fieldsToQuery.append("timestamp")
        } else if (!activityOids || forceFetch) && fields.filter({ $0 == "activities" }).count > 0 {
            fieldsToQuery.append("activities")
        } else if (!answerOid || forceFetch) && fields.filter({ $0 == "answer" }).count > 0 {
            fieldsToQuery.append("answer")
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
                    case "answer":
                        self.answerOid = value as? ObjectId
                        ModelBase.createModel(self.answerOid, modelPath: "question")
                    case "user":
                        self.userOid = value as? ObjectId
                        ModelBase.createModel(self.userOid, modelPath: "question")
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
        if let answerOid = answerOid {
            data["answerOid"] = answerOid
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