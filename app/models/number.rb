class Number < ApplicationRecord
  belongs_to :puzzle

  before_save :setup_numbers, :if => :new_record?

  def correct_answer_array
    correct_answer.chars.map{ |n| n.to_i }
  end

  def thinking_answer_array
    thinking_answer.chars.map{ |n| n.to_i.zero? ? nil : n.to_i }
  end

  private

  def setup_numbers
    logger.info "********** start setup_numbers **********"
    logger.info "creating correct_answer"
    correct_answer_array = generate_correct_answer_array
    self.correct_answer = correct_answer_array.join

    logger.info "creating question and thinking_answer"
    # TODO: 難易度に応じて、空白の数を変えたい
    self.question = generate_question(correct_answer_array)
    self.thinking_answer = self.question
    logger.info "********** finish setup_numbers **********"
  end

  def generate_correct_answer_array
    tmp_table = 81.times.map { |i| nil }
    table = []
    try_limit = 100 # 試行回数の上限

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

      try_limit.times do
        new_row = []
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
          row_numbers = new_row

          # ブロックの所属
          group_index = group_indexes.find_index { |group| group.include?(table_index) }
          group_numbers = group_indexes[group_index].map do |i|
                            table[i]
                          end

          # 値の選択
          reject_numbers = (column_numbers + row_numbers + group_numbers).compact.uniq
          base_numbers = (1..9).to_a.shuffle
          enable_numbers = base_numbers - reject_numbers
          new_row << enable_numbers.sample
        end

        unless new_row.include?(nil)
          table += new_row
          break
        end
      end
    end

    if table.include?(nil)
      logger.info "can't find numners! recreating a question"
      generate_correct_answer_array
    elsif table.size != 81
      logger.info "table size is not 81! recreating a question"
      generate_correct_answer_array
    else
      table
    end
  end

  def generate_question(question)
    question.each_slice(9).map do |row|
      hidden_cell = (0..8).to_a.sample(5)
      row.map do |cell|
        hidden_cell.include?(cell) ? 0 : cell
      end
    end.flatten.join
  end
end
