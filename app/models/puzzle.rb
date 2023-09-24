class Puzzle < ApplicationRecord
  before_create :setup_puzzle

  private

  def setup_puzzle
    question = generate_question
    self.question = question

    # TODO: 難易度に応じて、空白の数を変える。
    self.answer = generate_answer(question)
  end

  def generate_question
    tmp_table = 81.times.map { |i| nil }
    table = []

    tmp_table.each_slice(9).with_index do |row, row_index|
      if row_index.zero?
        table += (0..9).to_a.shuffle
        next
      end

      row.each_with_index do |column, column_index|
        table_index = 9 * row_index + column_index

        # 縦の所属
        select_indexes = []
        i = table_index
        while i >= 9 do
          i -=9
          select_indexes << i
        end
        target_column = select_indexes.map { |i| table[i] }
        
        # 横の所属
        target_row = table[(9 * row_index)..(9 * row_index + 8)].presence || []

        # ブロックの所属
        # TODO: imprement

        # 値の選択
        reject_numbers = (target_column + target_row).compact.uniq
        base_numbers = (0..9).to_a.shuffle
        enable_numbers = base_numbers - reject_numbers
        # TODO: enable_numbers が空の場合に対応する
        table << enable_numbers.sample
      end
    end

    table
  end

  def generate_answer(question)
    question.each_slice(9).map do |row|
      hidden_cell = (0..8).to_a.sample(5)
      row.map do |cell|
        hidden_cell.include?(cell) ? '' : cell
      end
    end.flatten
  end
end
