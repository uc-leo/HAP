import Foundation

public extension AnyCharacteristic {
    static func programmableSwitchOutputState(
        _ value: UInt8 = 0,
        permissions: [CharacteristicPermission] = [.read, .write, .events],
        description: String? = "Programmable Switch Output State",
        format: CharacteristicFormat? = .uint8,
        unit: CharacteristicUnit? = nil,
        maxLength: Int? = nil,
        maxValue: Double? = 1,
        minValue: Double? = 0,
        minStep: Double? = 1,
        validValues: [Double] = [],
        validValuesRange: Range<Double>? = nil
    ) -> AnyCharacteristic {
        AnyCharacteristic(
            PredefinedCharacteristic.programmableSwitchOutputState(
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
    static func programmableSwitchOutputState(
        _ value: UInt8 = 0,
        permissions: [CharacteristicPermission] = [.read, .write, .events],
        description: String? = "Programmable Switch Output State",
        format: CharacteristicFormat? = .uint8,
        unit: CharacteristicUnit? = nil,
        maxLength: Int? = nil,
        maxValue: Double? = 1,
        minValue: Double? = 0,
        minStep: Double? = 1,
        validValues: [Double] = [],
        validValuesRange: Range<Double>? = nil
    ) -> GenericCharacteristic<UInt8> {
        GenericCharacteristic<UInt8>(
            type: .programmableSwitchOutputState,
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
