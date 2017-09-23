import XCTest
@testable import BZipCompression

class BZipCompressionTests: XCTestCase {
    
    var coverageResource: URL {
        let path = FileManager.default.currentDirectoryPath
        let url = URL(fileURLWithPath: path).appendingPathComponent("Tests").appendingPathComponent("BZipCompressionTests").appendingPathComponent("coverage.bz2")
        return url
    }
    
    func testLocalPath() {
        let url = self.coverageResource
        print(url)
        XCTAssertTrue(url.lastPathComponent == "coverage.bz2")
    }
    
    func testDecompression() {
//        let bundle = Bundle(for: BZipCompressionTests.self)
//        guard let url = bundle.url(forResource: "coverage", withExtension: "bz2") else {
//            XCTFail("Failed to locate resource.")
//            return
//        }
        
        let data: Data
        do {
            data = try Data(contentsOf: self.coverageResource)
        } catch {
            XCTFail(error.localizedDescription)
            return
        }
        
        let decompressedData: Data
        do {
            decompressedData = try BZipCompression.decompressedData(with: data)
        } catch {
            XCTFail(error.localizedDescription)
            return
        }
        
        guard let decompressedString = String(data: decompressedData, encoding: .utf8) else {
            XCTFail("Failed to decompress string.")
            return
        }
    
        guard let firstBrace = decompressedString.range(of: "{") else {
            XCTFail("First Brace not found.")
            return
        }
    
        guard let lastBrace = decompressedString.range(of: "}", options: .backwards, range: nil, locale: nil) else {
            XCTFail("Last Brace not found.")
            return
        }
    
        let range = decompressedString.index(firstBrace.lowerBound, offsetBy: 0)..<decompressedString.index(lastBrace.lowerBound, offsetBy: 1)
        let json = decompressedString[range]
    
        XCTAssertTrue(json != "")
    }
    
}
