private let automergeLowercaseHexDigits: [Character] = [
    "0", "1", "2", "3", "4", "5", "6", "7",
    "8", "9", "a", "b", "c", "d", "e", "f",
]

private let automergeUppercaseHexDigits: [Character] = [
    "0", "1", "2", "3", "4", "5", "6", "7",
    "8", "9", "A", "B", "C", "D", "E", "F",
]

extension Sequence where Element == UInt8 {
    func automergeHexString(uppercase: Bool = false) -> String {
        let digits = uppercase ? automergeUppercaseHexDigits : automergeLowercaseHexDigits
        var result = ""
        for byte in self {
            result.append(digits[Int(byte >> 4)])
            result.append(digits[Int(byte & 0x0f)])
        }
        return result
    }
}
