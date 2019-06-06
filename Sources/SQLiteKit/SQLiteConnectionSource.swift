public final class SQLiteConnectionSource: ConnectionPoolSource {
    public var eventLoop: EventLoop
    private let storage: SQLiteConnection.Storage
    private let threadPool: NIOThreadPool

    public init(configuration: SQLiteConfiguration, threadPool: NIOThreadPool, on eventLoop: EventLoop) {
        switch configuration.storage {
        case .memory:
            self.storage = .file(path: "file:\(ObjectIdentifier(threadPool))?mode=memory&cache=shared")
        case .connection(let storage):
            self.storage = storage
        }
        self.threadPool = threadPool
        self.eventLoop = eventLoop
    }

    public func makeConnection() -> EventLoopFuture<SQLiteConnection> {
        return SQLiteConnection.open(storage: self.storage, threadPool: self.threadPool, on: self.eventLoop)
    }
}

public struct SQLiteConfiguration {
    public enum Storage {
        case memory
        case connection(SQLiteConnection.Storage)
    }

    public var storage: Storage

    public init(storage: Storage) {
        self.storage = storage
    }
}

extension SQLiteConnection: ConnectionPoolItem { }