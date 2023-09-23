class Puzzle < ApplicationRecord
  before_create :setup_puzzle

  private

  def setup_puzzle
    # TODO: ひとまず数字を埋めている。ちゃんとした問題をつくる。
    question = []
    9.times do |i|
      question << (1..9).to_a.shuffle
    end
    self.question = question

    # TODO: 難易度に応じて、空白の数を変える。
    self.answer = question.dup.map do |row| 
                    hidden_cell = (0..8).to_a.sample(5)
                    row.map do |cell|
                      hidden_cell.include?(cell) ? '' : cell
                    end
                  end
  end
end
