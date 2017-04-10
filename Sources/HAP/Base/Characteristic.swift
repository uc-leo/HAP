import Foundation

protocol Characteristic: class, JSONSerializable {
    weak var service: Service? { get set }
    var iid: Int { get set }
    var type: CharacteristicType { get }
    var permissions: [CharacteristicPermission] { get }
    func getValue() -> Any?
    func setValue(_:Any?, fromConnection: Server.Connection?) throws
    var description: String? { get }
    var format: CharacteristicFormat? { get }
    var unit: CharacteristicUnit? { get }
    var maxLength: Int? { get }
    var maxValue: Double? { get }
    var minValue: Double? { get }
    var minStep: Double? { get }
}

extension Characteristic {
    public func serialized() -> [String : Any] {
        var serialized: [String : Any] = [
            "iid": iid,
            "type": type.rawValue,
            "perms": permissions.map { $0.rawValue }
        ]
        if let value = getValue() { serialized["value"] = value }
        
        if let description = description { serialized["description"] = description }
        if let format = format { serialized["format"] = format.rawValue }
        if let unit = unit { serialized["unit"] = unit.rawValue }

        if let maxLength = maxLength { serialized["maxLength"] = maxLength }
        if let maxValue = maxValue { serialized["maxValue"] = maxValue }
        if let minValue = minValue { serialized["minValue"] = minValue }
        if let minStep = minStep { serialized["minStep"] = minStep }
        
        return serialized
    }
}

public class GenericCharacteristic<T: CharacteristicValueType>: Characteristic, JSONSerializable {
    enum Error: Swift.Error {
        case valueTypeException
    }
    
    weak var service: Service?

    var iid: Int
    public let type: CharacteristicType

    internal var _value: T?
    public var value: T? {
        get {
            return _value
        }
        set {
            guard newValue != _value else { return }
            _value = newValue
            guard let device = service?.accessory?.device else { return }
            device.notify(characteristicListeners: self)
        }
    }

    func getValue() -> Any? {
        return value
    }
    
    func setValue(_ newValue: Any?, fromConnection connection: Server.Connection?) throws {
        switch newValue {
        case let some?:
            guard let newValue = T(value: some) else {
                throw Error.valueTypeException
            }
            _value = newValue
        case .none:
            _value = nil
        }
        guard let device = service?.accessory?.device else { return }
        device.notify(characteristicListeners: self, exceptListener: connection)
    }
    
    // Subscribe a listener to value changes from (remote) clients.
    public var onValueChange: [(T?) -> ()] = []

    let permissions: [CharacteristicPermission]

    let description: String?
    let format: CharacteristicFormat?
    let unit: CharacteristicUnit?

    let maxLength: Int?
    let maxValue: Double?
    let minValue: Double?
    let minStep: Double?

    init(iid: Int = 0, type: CharacteristicType, value: T? = nil, permissions: [CharacteristicPermission] = [.read, .write, .events], description: String? = nil, format: CharacteristicFormat? = nil, unit: CharacteristicUnit? = nil, maxLength: Int? = nil, maxValue: Double? = nil, minValue: Double? = nil, minStep: Double? = nil) {
        self.iid = iid
        self.type = type
        self._value = value
        self.permissions = permissions

        self.description = description
        self.format = format ?? T.format
        self.unit = unit

        self.maxLength = maxLength
        self.maxValue = maxValue
        self.minValue = minValue
        self.minStep = minStep
    }

    public func setValue(_ newValue: T?, fromConnection connection: Server.Connection) {
        let newValue = newValue.flatMap { T(value: $0) }
        guard newValue != _value else { return }
        _value = newValue
        _ = onValueChange.map { $0(_value) }
    }
}

extension GenericCharacteristic: Hashable {
    public var hashValue: Int {
        return iid.hashValue
    }
}

extension GenericCharacteristic: Equatable {
    public static func == (lhs: GenericCharacteristic, rhs: GenericCharacteristic) -> Bool {
        return lhs === rhs
    }
}
