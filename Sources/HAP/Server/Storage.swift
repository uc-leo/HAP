import COperatingSystem
import Foundation

public protocol Storage: AnyObject {
    func read() throws -> Data
    func write(_: Data) throws
}

public class FileStorage: Storage {
    let filename: String

    /// Creates a new instance that will store the device configuration
    /// at the given file path.
    ///
    /// - Parameter filename: path to the file
    public init(filename: String) {
        self.filename = filename
    }

    public func read() throws -> Data {
        let fd = fopen(filename, "r")
        if fd == nil { try throwError() }
        try posix(fseek(fd, 0, COperatingSystem.SEEK_END))
        let size = ftell(fd)
        rewind(fd)
        var buffer = Data(count: size)
        _ = buffer.withUnsafeMutableBytes {
            COperatingSystem.fread($0.bindMemory(to: UInt8.self).baseAddress!, size, 1, fd)
        }
        fclose(fd)
        return buffer
    }

    public func write(_ newValue: Data) throws {
        let fd = COperatingSystem.fopen(filename, "w")
        _ = newValue.withUnsafeBytes {
            COperatingSystem.fwrite($0.bindMemory(to: UInt8.self).baseAddress!, newValue.count, 1, fd)
        }
        fclose(fd)
    }
}

public class MemoryStorage: Storage {
    var memory = Data()

    public init() {}

    public func read() throws -> Data {
        memory
    }

    public func write(_ newValue: Data) throws {
        memory = newValue
    }
}
