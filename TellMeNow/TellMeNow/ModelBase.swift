//
//  ModelBase.swift
//  TellMeNow
//
//  Created by Gautham Badhrinathan on 6/6/14.
//  Copyright (c) 2014 House Boelter. All rights reserved.
//

import Foundation
import Agent

typealias EmptyCallback = () -> ()
typealias AnyDict = Dictionary<String, AnyObject>
typealias CallbackWithAnyDict = AnyDict -> ()
typealias ObjectId = String

let apiPath = "https://tellmenow.herokuapp.com"
var accessToken: String?

class ModelBase {
    var oid: ObjectId?
    let modelPath: String
    
    init(oid: ObjectId?, modelPath: String) {
        self.oid = oid
        self.modelPath = modelPath
        if let oid = oid {
            modelsCache[oid] = self
        }
    }
    
    func load(callback: CallbackWithAnyDict, fields: String[] = ["*"]) {
        if let oid = oid {
            var payload: AnyDict = ["oid": oid, "fields": fields]
            if let accessToken = accessToken {
                payload["accessToken"] = accessToken
            }
            
            Agent.get("\(apiPath)/\(modelPath)").send(payload).end { callback($0.1 as AnyDict) }
        } else {
            callback([:])
        }
    }
    
    func save(var data: AnyDict, callback: EmptyCallback) {
        if let oid = oid {
            data["oid"] = oid
        }
        var payload: AnyDict = ["data": data]
        if let accessToken = accessToken {
            payload["accessToken"] = accessToken
        }
        Agent.put("\(apiPath)/\(modelPath)").send(payload).end {
            if let oid = ($0.1 as? AnyDict)?["oid"] as? ObjectId {
                self.oid = oid
                modelsCache[oid] = self
            }
            callback()
        }
    }
}

var modelsCache = Dictionary<String, ModelBase>()

protocol ModelProtocol {
    init (oid: ObjectId?)
    func load(callback: EmptyCallback, fields: String[], forceFetch: Bool)
    func save(callback: EmptyCallback)
}