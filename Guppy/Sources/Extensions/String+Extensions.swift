//
//  String+Extensions.swift
//
//  Copyright © 2019 Johnson & Johnson
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

extension String {
    
    func highlight(searchText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        let range = NSRange(location: 0, length: count)
        let regex = try? NSRegularExpression(pattern: searchText.escapeQuotes(), options: .caseInsensitive)
        attributedString.addAttribute(.font, value: UIFont(name: "HelveticaNeue", size: 17.0)!, range: range)
        
        regex?.enumerateMatches(in: self, options: .reportProgress, range: range) { textCheckingResult, _, _ in
            guard let subRange = textCheckingResult?.range else {
                return
            }
            attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: subRange)
        }
        
        return attributedString
    }
    
    /// Returns true if the string matches the regex
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// Removes the backslashes from the text
    func removeBackslashes() -> String {
        return self.replacingOccurrences(of: "\\", with: "")
    }
    
    /// Converts between the straight quotes and the slanted quotes
    func escapeQuotes() -> String {
        let quotedText = self.replacingOccurrences(of: "“|”", with: "[\"|”]", options: .regularExpression, range: nil)
        return quotedText
    }
}
