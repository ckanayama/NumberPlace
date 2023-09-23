class PuzzlesController < ApplicationController
  def index
    @puzzle = Puzzle.all
  end

  def show
    @puzzle = Puzzle.find(params[:id])
    @answer = @puzzle.answer
  end
end
