# DecodingJasonInSwift4
A simplify way to parse Json from Restful API

Swift 4 introduces a new way to generate & parse JSON using the Codable protocol. It’ll get rid of some boilerplate, especially when the objects or structs in our code have a similar structure to the JSON that we use to talk to a web service. In many cases you’ll be able to avoid writing any code that explicitly parses or generates JSON, even if your Swift structs don’t exactly match the JSON structure. That means no more long, ugly toJSON() or init?(json: [String: Any]) functions.

This a simple project to demonstrate the way to parse Json with nested type.
