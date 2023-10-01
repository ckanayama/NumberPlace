class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.order(updated_at: :desc)
  end

  def create
    puzzle = Puzzle.new
    puzzle.build_number
    puzzle.save!

    redirect_to puzzle_path(puzzle)
  end

  def show
    @puzzle = Puzzle.find(params[:id])
  end

  def update
    puzzle = Puzzle.find(params[:id])
    new_answer_array = puzzle.number.thinking_answer_array

    answer_params.each do |k, v|
      next if v.blank?
      index = k.split('_').last.to_i
      new_answer_array[index] = v.to_i
    end

    puzzle.update!(status: status_param)
    puzzle.number.update!(thinking_answer: new_answer_array.map { |n| n.nil? ? 0 : n }.join)

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
end
