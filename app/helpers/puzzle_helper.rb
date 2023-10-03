module PuzzleHelper
  def wrong_answer?(index, column)
    return false unless @puzzle.status == 'submitted' 
    return false if column.blank?

    @puzzle.number.correct_answer_array[index] != column
  end
end
