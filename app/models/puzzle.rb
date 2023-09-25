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

    group_indexes = [0, 3, 6, 27, 30, 33, 54, 57, 60].map do |i|
      (i..(i + 2)).to_a + (i + 9..(i + 11)).to_a + (i + 18..(i + 20)).to_a
    end
    # group_indexes
    # ---------------------------------------
    # | group_indexes[0] |  group_indexes[1] |  group_indexes[2] |
    # | group_indexes[3] |  group_indexes[4] |  group_indexes[5] |
    # | group_indexes[6] |  group_indexes[7] |  group_indexes[8] |
    # ---------------------------------------

    tmp_table.each_slice(9).with_index do |row, row_index|
      if row_index.zero?
        table += (1..9).to_a.shuffle
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
        column_numbers = select_indexes.map { |i| table[i] }
        
        # 横の所属
        row_numbers = table[(9 * row_index)..(9 * row_index + 8)].presence || []

        # ブロックの所属
        group_index = group_indexes.find_index { |group| group.include?(table_index) }
        group_numbers = group_indexes[group_index].map do |i|
                          table[i]
                        end

        # 値の選択
        reject_numbers = (column_numbers + row_numbers + group_numbers).compact.uniq
        base_numbers = (1..9).to_a.shuffle
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
