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
    answer_params.each do |k, v|
      next if v.blank?
      # TODO: answer の k番目を v.to_i の値に更新する
    end
    # puzzle.update!(answer: params[:answer])

    # redirect_to puzzle_path(puzzle)
  end

  private

  def answer_params
    permit_indexes = (0..80).to_a.map { |n| "index_#{n}".to_sym }
    params.require(:answer).permit(permit_indexes)
  end
end
