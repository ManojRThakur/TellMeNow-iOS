//
//  ActivityModel.swift
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 6/12/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

import Foundation

enum AttachedObject {
    case Answer(AnswerModel)
    case Comment(CommentModel)
    case FollowUp(FollowUpModel)
    case Question(QuestionModel)
    case User(UserModel)
}

class ActivityModel: ModelBase, ModelProtocol {
    var text: String?
    var timestamp: NSDate?
    var attachedObjectRef: (oid: ObjectId, type: String)?
    
    var attachedObject: AttachedObject? {
    get {
        if let attachedObjectRef = attachedObjectRef {
            switch attachedObjectRef.type {
            case "answer":
                if let answer = modelsCache[attachedObjectRef.oid] as? AnswerModel {
                    return AttachedObject.Answer(answer)
                }
            case "comment":
                if let comment = modelsCache[attachedObjectRef.oid] as? CommentModel {
                    return AttachedObject.Comment(comment)
                }
            case "followUp":
                if let followUp = modelsCache[attachedObjectRef.oid] as? FollowUpModel {
                    return AttachedObject.FollowUp(followUp)
                }
            case "question":
                if let question = modelsCache[attachedObjectRef.oid] as? QuestionModel {
                    return AttachedObject.Question(question)
                }
            case "user":
                if let user = modelsCache[attachedObjectRef.oid] as? UserModel {
                    return AttachedObject.User(user)
                }
            default:
                return nil
            }
        }
        return nil
    }
    }
    
    init(oid: ObjectId?) {
        super.init(oid: oid, modelPath: "answer")
    }
    
    func load(callback: EmptyCallback, fields: String[] = ["text", "timestamp", "attachedObject"], forceFetch: Bool = false) {
        var fieldsToQuery = String[]()
        
        if (!text || forceFetch) && fields.filter({ $0 == "text" }).count > 0 {
            fieldsToQuery.append("text")
        } else if (!timestamp || forceFetch) && fields.filter({ $0 == "timestamp" }).count > 0 {
            fieldsToQuery.append("timestamp")
        } else if (!attachedObjectRef || forceFetch) && fields.filter({ $0 == "attachedObject" }).count > 0 {
            fieldsToQuery.append("attachedObject")
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
                    case "attachedObject":
                        let dict = value as? AnyDict
                        if dict {
                            self.attachedObjectRef = (oid: dict?["oid"] as ObjectId, type: dict?["type"] as String)
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
        if let text = text {
            data["text"] = text
        }
        if let timestamp = timestamp {
            data["timestamp"] = timestamp.timeIntervalSince1970
        }
        if let attachedObjectRef = attachedObjectRef {
            data["attachedObject"] = ["oid": attachedObjectRef.oid, "type": attachedObjectRef.type] as AnyDict
        }
        if data.count == 0 {
            callback()
        } else {
            super.save(data, callback)
        }
    }
}