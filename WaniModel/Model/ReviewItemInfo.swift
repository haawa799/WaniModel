//
//  Item.swift
//  WaniTokei
//
//  Created by Andriy K. on 8/30/16.
//  Copyright © 2016 haawa. All rights reserved.
//

import Foundation

public enum ReviewItemInfo: WaniKaniDataStructure {

  struct DictKeys {
    static let type = "type"
    static let kanji = "kanji"
    static let radical = "radical"
    static let word = "vocabulary"
  }

  case kanji(KanjiInfo)
  case word(WordInfo)
  case radical(RadicalInfo)

  public init(dict: [String : Any]) throws {
    guard let type = dict[DictKeys.type] as? String else { throw InitialisationError.initialisationProblem }
    switch type {
    case DictKeys.radical:
      self = try ReviewItemInfo.radical(RadicalInfo(dict: dict))
      return
    case DictKeys.kanji:
      self = try ReviewItemInfo.kanji(KanjiInfo(dict: dict))
      return
    case DictKeys.word:
      self = try ReviewItemInfo.word(WordInfo(dict: dict))
      return
    default: throw InitialisationError.initialisationProblem
    }
  }

  public var mainTitle: String {
    switch self {
    case .radical(let radical): return radical.character ?? ""
    case .kanji(let kanji): return kanji.character
    case .word(let word): return word.character
    }
  }

  public var percentage: String? {
    switch self {
    case .radical(let radical): return radical.percentage
    case .kanji(let kanji): return kanji.percentage
    case .word(let word): return word.percentage
    }
  }

  public var unlockedDate: Date? {
    switch self {
    case .radical(let radical): return radical.unlockedDate
    case .kanji(let kanji): return kanji.unlockedDate
    case .word(let word): return word.unlockedDate
    }
  }

  public var meaning: String? {
    switch self {
    case .radical(let radical): return radical.meaning
    case .kanji(let kanji): return kanji.meaning
    case .word(let word): return word.meaning
    }
  }

  public var reading: String? {
    switch self {
    case .radical: return ""
    case .kanji(let kanji): return kanji.reading
    case .word(let word): return word.kana
    }
  }

}

public func ==(lhs: ReviewItemInfo, rhs: ReviewItemInfo) -> Bool {
  if case let ReviewItemInfo.radical(radicalLHS) = lhs, case let ReviewItemInfo.radical(radicalRHS) = rhs {
    return radicalLHS == radicalRHS
  }
  if case let ReviewItemInfo.kanji(kanjiLHS) = lhs, case let ReviewItemInfo.kanji(kanjiRHS) = rhs {
    return kanjiLHS == kanjiRHS
  }
  if case let ReviewItemInfo.word(wordLHS) = lhs, case let ReviewItemInfo.word(wordRHS) = rhs {
    return wordLHS == wordRHS
  }
  return false
}
