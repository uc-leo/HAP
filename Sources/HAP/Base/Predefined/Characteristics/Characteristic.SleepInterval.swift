import Foundation

public extension AnyCharacteristic {
    static func sleepInterval(
        _ value: UInt32 = 0,
        permissions: [CharacteristicPermission] = [.read, .events],
        description: String? = "Sleep Interval",
        format: CharacteristicFormat? = .uint32,
        unit: CharacteristicUnit? = nil,
        maxLength: Int? = nil,
        maxValue: Double? = nil,
        minValue: Double? = 0,
        minStep: Double? = 1,
        validValues: [Double] = [],
        validValuesRange: Range<Double>? = nil
    ) -> AnyCharacteristic {
        AnyCharacteristic(
            PredefinedCharacteristic.sleepInterval(
            value,
            permissions: permissions,
            description: description,
            format: format,
            unit: unit,
            maxLength: maxLength,
            maxValue: maxValue,
            minValue: minValue,
            minStep: minStep,
            validValues: validValues,
            validValuesRange: validValuesRange) as Characteristic)
    }
}

public extension PredefinedCharacteristic {
    static func sleepInterval(
        _ value: UInt32 = 0,
        permissions: [CharacteristicPermission] = [.read, .events],
        description: String? = "Sleep Interval",
        format: CharacteristicFormat? = .uint32,
        unit: CharacteristicUnit? = nil,
        maxLength: Int? = nil,
        maxValue: Double? = nil,
        minValue: Double? = 0,
        minStep: Double? = 1,
        validValues: [Double] = [],
        validValuesRange: Range<Double>? = nil
    ) -> GenericCharacteristic<UInt32> {
        GenericCharacteristic<UInt32>(
            type: .sleepInterval,
            value: value,
            permissions: permissions,
            description: description,
            format: format,
            unit: unit,
            maxLength: maxLength,
            maxValue: maxValue,
            minValue: minValue,
            minStep: minStep,
            validValues: validValues,
            validValuesRange: validValuesRange)
    }
}
