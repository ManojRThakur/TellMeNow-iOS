//
//  Model.swift
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 6/6/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

import Foundation
import Agent

typealias EmptyCallback = () -> ()

enum Thumbs{
    case None
    case ThumbsUp
    case ThumbsDown
}

class ModelBase {
    let oid: String
    var isLoaded = false
    
    init(oid: String) {
        self.oid = oid
    }
    
    func load(fields: String[] = ["*"], callback: EmptyCallback) { }
}

let apiPath = "https://tellmenow.herokuapp.com"
var modelsCache = Dictionary<String, ModelBase>()

class AnswerModel: ModelBase {
    var reputation: Int?
    var text: String?
    var thumbs: Thumbs?
    var timestamp: NSDate?
    
    init(oid: String) {
        super.init(oid: oid)
        modelsCache[oid] = self
    }
    
    override func load(fields: String[] = ["*"], callback: EmptyCallback) {
        if isLoaded {
            callback()
        } else {
            Agent.get("\(apiPath)/answer") { (error: NSError?, response: NSHTTPURLResponse?, data: AnyObject?) in
                callback()
            }
        }
    }
}