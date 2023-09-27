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
    @answer = @puzzle.answer
    @question = @puzzle.question
  end

  def update
    puzzle = Puzzle.find(params[:id])
    new_answer = puzzle.answer.dup

    answer_params.each do |k, v|
      next if v.blank?
      index = k.split('_').last.to_i
      new_answer[index] = v.to_i
    end

    puzzle.update!(answer: new_answer)

    redirect_to puzzle_path(puzzle)
  end

  private

  def answer_params
    permit_indexes = (0..80).to_a.map { |n| "index_#{n}".to_sym }
    params.require(:answer).permit(permit_indexes)
  end
end
