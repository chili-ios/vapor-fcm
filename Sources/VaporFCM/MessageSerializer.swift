// (c) 2017 Kajetan Michal Dabrowski
// This code is licensed under MIT license (see LICENSE for details)

import Jay

/// This object turns messages int json data
public class MessageSerializer {

    private enum MessageKey: String {
        case dryRun = "dry_run"
        case notification = "notification"
        case data = "data"
        case contentAvailable = "content_available"
        case mutableContent = "mutable_content"
    }

    public func serialize(message: Message, target: Targetable) throws -> [UInt8] {
        let json: [String: Any] = serialize(message: message, target: target)
        return try Jay(formatting: .minified).dataFromJson(jsonWrapper: JaySON(json))
    }

    public func serialize(message: Message, targets: [Targetable]) throws -> [UInt8] {
        var json = serialize(message: message)
        json["registration_ids"] = targets.map { $0.targetValue }
        return try Jay(formatting: .minified).dataFromJson(jsonWrapper: JaySON(json))
    }

    public func serialize(message: Message, target: Targetable) -> [String: Any] {
        var json = self.serialize(message: message)
        json[target.targetKey] = target.targetValue
        return json
    }

    private func serialize(message: Message) -> [String: Any] {
        var json: [String: Any] = [:]

        if message.debug {
            json[MessageKey.dryRun.rawValue] = message.debug
        }
        if let payload = message.payload {
            json[MessageKey.notification.rawValue] = payload.makeJson()
        }
        if let data = message.data {
            json[MessageKey.data.rawValue] = data.makeJson()
        }
        if let contentAvailable = message.contentAvailable {
            json[MessageKey.contentAvailable.rawValue] = contentAvailable
        }
        if let mutableContent = message.mutableContent {
            json[MessageKey.mutableContent.rawValue] = mutableContent
        }
        return json
    }
}

