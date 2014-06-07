// Playground - noun: a place where people can play

var str = "Hello, playground"


class ModelBase {
    let oid: String
    var isLoaded = false
    init(oid: String) {
        self.oid = oid
    }
}

var modelsCache = Dictionary<String, ModelBase>()

class AnswerModel: ModelBase {
    init(oid: String) {
        super.init(oid: oid)
    }
}

func load(callback: () -> ()) {
    callback()
}

load {
    "Hello"
    return
}
