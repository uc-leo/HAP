import Foundation

public extension AnyCharacteristic {
    static func carbonMonoxidePeakLevel(
        _ value: Float = 0,
        permissions: [CharacteristicPermission] = [.read, .events],
        description: String? = "Carbon monoxide Peak Level",
        format: CharacteristicFormat? = .float,
        unit: CharacteristicUnit? = .ppm,
        maxLength: Int? = nil,
        maxValue: Double? = 100,
        minValue: Double? = 0,
        minStep: Double? = 1,
        validValues: [Double] = [],
        validValuesRange: Range<Double>? = nil
    ) -> AnyCharacteristic {
        AnyCharacteristic(
            PredefinedCharacteristic.carbonMonoxidePeakLevel(
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
    static func carbonMonoxidePeakLevel(
        _ value: Float = 0,
        permissions: [CharacteristicPermission] = [.read, .events],
        description: String? = "Carbon monoxide Peak Level",
        format: CharacteristicFormat? = .float,
        unit: CharacteristicUnit? = .ppm,
        maxLength: Int? = nil,
        maxValue: Double? = 100,
        minValue: Double? = 0,
        minStep: Double? = 1,
        validValues: [Double] = [],
        validValuesRange: Range<Double>? = nil
    ) -> GenericCharacteristic<Float> {
        GenericCharacteristic<Float>(
            type: .carbonMonoxidePeakLevel,
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
