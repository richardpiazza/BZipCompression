import XCTest
@testable import BZipCompression

class BZipCompressionTests: XCTestCase {
    
    public func url(forResource resource: String) -> URL {
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: resource, withExtension: "bz2") {
            return url
        }
        
        let path = FileManager.default.currentDirectoryPath
        let url = URL(fileURLWithPath: path).appendingPathComponent("Tests").appendingPathComponent("BZipCompressionTests").appendingPathComponent(resource).appendingPathExtension("bz2")
        
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("Failed to locate resource \(resource).bz2")
        }
        
        return url
    }
    
    func testDecompression() {
        let url = self.url(forResource: "coverage")
        
        let data: Data
        do {
            data = try Data(contentsOf: url)
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
