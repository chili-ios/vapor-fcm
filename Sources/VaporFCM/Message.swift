// (c) 2017 Kajetan Michal Dabrowski
// This code is licensed under MIT license (see LICENSE for details)

import Jay

/// This represents a message that you can send via Firebase
public struct Message {

    /// The payload of the message
    public let payload: Payload?

    /// Extra deta of a message
    public let data: MessageData?

    public let contentAvailable: Bool?
    public let mutableContent: Bool?

    /// If you set this to true, the message won't actually be sent to the device, just to Firebase to indicate the result
    public var debug: Bool = false

    public init(payload: Payload?, data: MessageData? = nil, contentAvailable: Bool? = nil, mutableContent: Bool? = nil) {
        self.payload = payload
        self.data = data
        self.contentAvailable = contentAvailable
        self.mutableContent = mutableContent
    }
}

extension Message: Equatable {
    public static func ==(lhs: Message, rhs: Message) -> Bool {
        return lhs.payload == rhs.payload
            && lhs.data == rhs.data
    }
}

