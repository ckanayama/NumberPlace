class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.order(created_at: :desc)
  end

  def create
    puzzle = Puzzle.create!

    redirect_to puzzle_path(puzzle)
  end

  def show
    @puzzle = Puzzle.find(params[:id])

    # NOTE: 時々Stringとなってしまうため。ひとまず変換しているが、原因を調査したい。
    @answer = formatted_answer(@puzzle.answer)
    @question = formatted_question(@puzzle.question)
  end

  def update
    puzzle = Puzzle.find(params[:id])
    new_answer = puzzle.answer.dup

    answer_params.each do |k, v|
      next if v.blank?
      index = k.split('_').last.to_i
      new_answer[index] = v.to_i
    end

    puzzle.update!(answer: new_answer, status: status_param)

    redirect_to puzzle_path(puzzle)
  end

  private

  def answer_params
    permit_indexes = (0..80).to_a.map { |n| "index_#{n}".to_sym }
    params.require(:answer).permit(permit_indexes)
  end

  def status_param
    params.require(:status)
  end

  def formatted_answer(answer)
    return answer if answer.is_a?(Array)
    logger.info('answer is not Array!!')
    answer.delete('{').delete('}').split(',').map{ |n| n == 'NULL' ? nil : n.to_i}
  end

  def formatted_question(question)
    return question if question.is_a?(Array)
    logger.info('question is not Array!!')
    question.delete('{').delete('}').split(',').map{ |n| n == 'NULL' ? nil : n.to_i}
  end
end
