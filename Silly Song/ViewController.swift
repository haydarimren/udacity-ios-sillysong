//
//  ViewController.swift
//  Silly Song
//
//  Created by Imren, Haydar on 11/20/16.
//  Copyright © 2016 Imren, Haydar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlet for the name text field.
    @IBOutlet weak var nameField: UITextField!
    
    // Outlet for the lyrics text view.
    @IBOutlet weak var lyricsView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Clear the nameField and lyricsView texts when user clicks on the nameField.
    @IBAction func reset(_ sender: Any) {
        nameField.text = "";
        lyricsView.text = "";
    }
    
    // Once the user puts their name in the nameField, lyrics will be generated and put into the lyricsView.
    @IBAction func displayLyrics(_ sender: Any) {
        if(!(nameField.text?.isEmpty)!) {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
        }
    }

}

// template for generating a silly song.
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

// returns a lowercased and leading consonants truncated version of the given string.
// if the given string is just a consonant then returns empty string
func shortNameFromName(name: String) -> String {
    let lowercase = name.lowercased()
    let nameCharacters = lowercase.characters
    let vowels = CharacterSet(charactersIn: "aeiou")
    
    let indexOfFirstVowel = lowercase.rangeOfCharacter(from: vowels, options: NSString.CompareOptions.caseInsensitive, range: nameCharacters.startIndex..<nameCharacters.endIndex)?.lowerBound
    let shortName = indexOfFirstVowel != nil ? lowercase.substring(from: indexOfFirstVowel!) : ""
    
    return shortName
}

// returns a silly song lyrics for the given name with the given template.
func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    let lyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    return lyrics
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

