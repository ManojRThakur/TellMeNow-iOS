//
//  UserModel.swift
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 6/11/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

import Foundation

class UserModel: ModelBase, ModelProtocol {
    var name: String?
    var asksAllowed: (number: Int, period: NSTimeInterval)?
    var reputation: Int?
    var answerOids: ObjectId[]?
    var commentOids: ObjectId[]?
    var followUpOids: ObjectId[]?
    var activityOids: ObjectId[]?
    var questionOids: ObjectId[]?
    
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
    
    var followUps: FollowUpModel[]? {
    get {
        return followUpOids?.map({ modelsCache[$0] as FollowUpModel })
    }
    }
    
    var activities: ActivityModel[]? {
    get {
        return activityOids?.map({ modelsCache[$0] as ActivityModel })
    }
    }
    
    var questions: QuestionModel[]? {
    get {
        return questionOids?.map({ modelsCache[$0] as QuestionModel })
    }
    }
    
    init(oid: ObjectId?) {
        super.init(oid: oid, modelPath: "user")
    }
    
    func load(callback: EmptyCallback, fields: String[] = ["name"], forceFetch: Bool = false) {
        var fieldsToQuery = String[]()
        
        if (!name || forceFetch) && fields.filter({ $0 == "name" }).count > 0 {
            fieldsToQuery.append("name")
        } else if (!asksAllowed || forceFetch) && fields.filter({ $0 == "asksAllowed" }).count > 0 {
            fieldsToQuery.append("asksAllowed")
        } else if (!reputation || forceFetch) && fields.filter({ $0 == "reputation" }).count > 0 {
            fieldsToQuery.append("reputation")
        } else if (!answerOids || forceFetch) && fields.filter({ $0 == "answers" }).count > 0 {
            fieldsToQuery.append("answers")
        } else if (!commentOids || forceFetch) && fields.filter({ $0 == "comments" }).count > 0 {
            fieldsToQuery.append("comments")
        } else if (!followUpOids || forceFetch) && fields.filter({ $0 == "followUps" }).count > 0 {
            fieldsToQuery.append("followUps")
        } else if (!activityOids || forceFetch) && fields.filter({ $0 == "activities" }).count > 0 {
            fieldsToQuery.append("activities")
        } else if (!questionOids || forceFetch) && fields.filter({ $0 == "questions" }).count > 0 {
            fieldsToQuery.append("questions")
        }
        
        if fieldsToQuery.isEmpty {
            callback()
        } else {
            super.load({
                for (key, value: AnyObject) in $0 {
                    switch key {
                    case "name":
                        self.name = value as? String
                    case "asksAllowed":
                        let dict = value as? AnyDict
                        if dict {
                            self.asksAllowed = (number: dict?["number"] as Int, period: dict?["period"] as NSTimeInterval)
                        }
                    case "reputation":
                        self.reputation = value as? Int
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
                    case "followUps":
                        self.followUpOids = value as? ObjectId[]
                        if let followUpOids = self.followUpOids {
                            for followUpOid in followUpOids {
                                ModelBase.createModel(followUpOid, modelPath: "followUp")
                            }
                        }
                    case "activities":
                        self.activityOids = value as? ObjectId[]
                        if let activityOids = self.activityOids {
                            for activityOid in activityOids {
                                ModelBase.createModel(activityOid, modelPath: "activity")
                            }
                        }
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
        if let name = name {
            data["name"] = name
        }
        if let asksAllowed = asksAllowed {
            data["asksAllowed"] = ["number": asksAllowed.number, "period": asksAllowed.period] as AnyDict
        }
        if let reputation = reputation {
            data["reputation"] = reputation
        }
        if let answerOids = answerOids {
            data["answerOids"] = answerOids
        }
        if let commentOids = commentOids {
            data["commentOids"] = commentOids
        }
        if let followUpOids = followUpOids {
            data["followUpOids"] = followUpOids
        }
        if let activityOids = activityOids {
            data["activityOids"] = activityOids
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
