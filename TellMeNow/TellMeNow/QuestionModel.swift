//
//  AnswerModel.swift
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 6/10/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

import Foundation

class QuestionModel: ModelBase, ModelProtocol {
    var text: String?
    var timestamp: NSDate?
    var answerOids: ObjectId[]?
    var commentOids: ObjectId[]?
    var activityOids: ObjectId[]?
    var placeOid: ObjectId?
    var userOid: ObjectId?
    
    var answers: AnswerModel[]? {
    get {
        return answerOids?.map({ modelsCache[$0] as AnswerModel })
    }
    }
    
    var comments: CommentModel[]? {
    get {
        return commentOids?.map({ modelsCache[$0] as CommentModel })
    }
    }
    
    var activities: ActivityModel[]? {
    get {
        return activityOids?.map({ modelsCache[$0] as ActivityModel })
    }
    }
    
    var place: PlaceModel? {
    get {
        return placeOid ? modelsCache[placeOid!] as? PlaceModel : nil
    }
    }
    
    var user: UserModel? {
    get {
        return userOid ? modelsCache[userOid!] as? UserModel : nil
    }
    }
    
    init(oid: ObjectId?) {
        super.init(oid: oid, modelPath: "question")
    }
    
    func load(callback: EmptyCallback, fields: String[] = ["text", "timestamp", "answers", "comments", "place", "user"], forceFetch: Bool = false) {
        var fieldsToQuery = String[]()
        
        if (!text || forceFetch) && fields.filter({ $0 == "text" }).count > 0 {
            fieldsToQuery.append("text")
        } else if (!timestamp || forceFetch) && fields.filter({ $0 == "timestamp" }).count > 0 {
            fieldsToQuery.append("timestamp")
        } else if (!answerOids || forceFetch) && fields.filter({ $0 == "answers" }).count > 0 {
            fieldsToQuery.append("answers")
        } else if (!commentOids || forceFetch) && fields.filter({ $0 == "comments" }).count > 0 {
            fieldsToQuery.append("comments")
        } else if (!activityOids || forceFetch) && fields.filter({ $0 == "activities" }).count > 0 {
            fieldsToQuery.append("activities")
        } else if (!placeOid || forceFetch) && fields.filter({ $0 == "place" }).count > 0 {
            fieldsToQuery.append("place")
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
                    case "answers":
                        self.answerOids = value as? ObjectId[]
                        if let answerOids = self.answerOids {
                            for answerOid in answerOids {
                                ModelBase.createModel(answerOid, modelPath: "answer")
                            }
                        }
                    case "comments":
                        self.commentOids = value as? ObjectId[]
                        if let commentOids = self.commentOids {
                            for commentOid in commentOids {
                                ModelBase.createModel(commentOid, modelPath: "comment")
                            }
                        }
                    case "activities":
                        self.activityOids = value as? ObjectId[]
                        if let activityOids = self.activityOids {
                            for activityOid in activityOids {
                                ModelBase.createModel(activityOid, modelPath: "activity")
                            }
                        }
                    case "place":
                        self.placeOid = value as? ObjectId
                        ModelBase.createModel(self.placeOid, modelPath: "place")
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
        if let answerOids = answerOids {
            data["answerOids"] = answerOids
        }
        if let commentOids = commentOids {
            data["commentOids"] = commentOids
        }
        if let activityOids = activityOids {
            data["activityOids"] = activityOids
        }
        if let placeOid = placeOid {
            data["placeOid"] = placeOid
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