class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.order(:created_at)
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
end
