module PuzzleHelper
  def wrong_answer?(index, column)
    return false unless @puzzle.status == 'submitted'

    @puzzle.number.correct_answer_array[index] != column
  end
end
