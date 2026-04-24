@testable import Automerge
import XCTest

class HexStringTests: XCTestCase {
    func testAutomergeHexStringLowercasePadsSingleNibbleBytes() {
        let bytes: [UInt8] = [0x00, 0x01, 0x0a, 0x0f, 0x10, 0xab, 0xff]

        XCTAssertEqual(bytes.automergeHexString(), "00010a0f10abff")
    }

    func testAutomergeHexStringUppercasePadsSingleNibbleBytes() {
        let bytes: [UInt8] = [0x00, 0x01, 0x0a, 0x0f, 0x10, 0xab, 0xff]

        XCTAssertEqual(bytes.automergeHexString(uppercase: true), "00010A0F10ABFF")
    }

    func testAutomergeHexStringWorksForDataAndSlices() {
        let data = Data([0x00, 0x10, 0xff])

        XCTAssertEqual(data.automergeHexString(), "0010ff")
        XCTAssertEqual(data[1 ..< 3].automergeHexString(), "10ff")
    }

    func testPublicHexDescriptionsUseExpectedCaseAndPadding() throws {
        let bytes: [UInt8] = [0x00, 0x01, 0x0a, 0x0f, 0x10, 0xab, 0xff]

        XCTAssertEqual(try XCTUnwrap(ActorId(data: Data(bytes))).description, "00010A0F10ABFF")
        XCTAssertEqual(ChangeHash(bytes: bytes).debugDescription, "00010a0f10abff")
        XCTAssertEqual(Cursor(bytes: bytes).description, "00010A0F10ABFF")
        XCTAssertEqual(ObjId(bytes: bytes).debugDescription, "ObjId(00010a0f10abff)")
        XCTAssertEqual(ScalarValue.Bytes(Data(bytes)).description, "Data(00010a0f10abff)")
        XCTAssertEqual(
            ScalarValue.Unknown(typeCode: 9, data: Data(bytes)).description,
            "Unknown(type: 9, data: 00010a0f10abff)"
        )
    }
}
