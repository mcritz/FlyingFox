//
//  App.swift
//  FlyingFoxCLI
//
//  Created by Simon Whitty on 19/02/2022.
//  Copyright © 2022 Simon Whitty. All rights reserved.
//
//  Distributed under the permissive MIT license
//  Get the latest version from here:
//
//  https://github.com/swhitty/FlyingFoxCLI
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import FlyingFox

@main
struct App {

    static func main() async throws {
        let server = HTTPServer(port: parsePort() ?? 80, logger: .print())
        await server.appendHandler(for: "*", closure: Self.helloWorld)
        try await server.start()
    }

    @Sendable
    static func helloWorld(_ request: HTTPRequest) async throws -> HTTPResponse {
        return HTTPResponse(statusCode: .ok,
                            headers: [.contentType: "text/plain"],
                            body: "Hello World!".data(using: .utf8)!)
    }

    static func parsePort(from args: [String] = Swift.CommandLine.arguments) -> UInt16? {
        var last: String?
        for arg in args {
            if last == "--port" {
                return UInt16(arg)
            }
            last = arg
        }
        return nil
    }
}
