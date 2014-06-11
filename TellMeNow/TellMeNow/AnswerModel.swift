//
//  AnswerModel.swift
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 6/10/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

import Foundation

enum Thumbs: String {
    case None = "none"
    case ThumbsUp = "thumbsUp"
    case ThumbsDown = "thumbsDown"
}

class AnswerModel: ModelBase, ModelProtocol {
    var reputation: Int?
    var text: String?
    var thumbs: Thumbs?
    var timestamp: NSDate?
    var followUpOids: ObjectId[]?
    var activityOids: ObjectId[]?
    var questionOid: ObjectId?
    var userOid: ObjectId?
    
    var question: QuestionModel? {
    get {
        return questionOid ? modelsCache[questionOid!] as? QuestionModel : nil
    }
    }
    
    init(oid: ObjectId?) {
        super.init(oid: oid, modelPath: "answer")
    }
    
    func load(callback: EmptyCallback, fields: String[] = ["reputation", "text", "thumbs", "timestamp", "followUps", "user"], forceFetch: Bool = false) {
        var fieldsToQuery = String[]()
        
        if (!reputation || forceFetch) && fields.filter({ $0 == "reputation" }).count > 0 {
            fieldsToQuery.append("reputation")
        } else if (!text || forceFetch) && fields.filter({ $0 == "text" }).count > 0 {
            fieldsToQuery.append("text")
        } else if (!thumbs || forceFetch) && fields.filter({ $0 == "thumbs" }).count > 0 {
            fieldsToQuery.append("thumbs")
        } else if (!timestamp || forceFetch) && fields.filter({ $0 == "timestamp" }).count > 0 {
            fieldsToQuery.append("timestamp")
        } else if (!followUpOids || forceFetch) && fields.filter({ $0 == "followUps" }).count > 0 {
            fieldsToQuery.append("followUps")
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
                    case "reputation":
                        self.reputation = value as? Int
                    case "text":
                        self.text = value as? String
                    case "thumbs":
                        self.thumbs = Thumbs.fromRaw(value as String)
                    case "timestamp":
                        self.timestamp = NSDate(timeIntervalSince1970: value as NSTimeInterval)
                    case "followUps":
                        self.followUpOids = value as? ObjectId[]
                        if let followUpOids = self.followUpOids {
                            for followUpOid in followUpOids {
                                if (!modelsCache[followUpOid]) {
                                    modelsCache[followUpOid] = ModelBase(oid: followUpOid, modelPath: "followUp")
                                }
                            }
                            
                        }
                    case "activities":
                        self.activityOids = value as? ObjectId[]
                        if let activityOids = self.activityOids {
                            for activityOid in activityOids {
                                if (!modelsCache[activityOid]) {
                                    modelsCache[activityOid] = ModelBase(oid: activityOid, modelPath: "activity")
                                }
                            }
                            
                        }
                    case "question":
                        self.questionOid = value as? ObjectId
                    case "user":
                        self.userOid = value as? ObjectId
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
        if let reputation = reputation {
            data["reputation"] = reputation
        }
        if let text = text {
            data["text"] = text
        }
        if let thumbs = thumbs {
            data["thumbs"] = thumbs.toRaw()
        }
        if let timestamp = timestamp {
            data["timestamp"] = timestamp.timeIntervalSince1970
        }
        if let followUpOids = followUpOids {
            data["followUpOids"] = followUpOids
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