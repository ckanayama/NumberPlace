class PuzzlesController < ApplicationController
  before_action :set_puzzle, only: [:show, :update, :reset, :destroy]
  before_action :set_setting, only: [:create]

  def index
    flash[:notice] = 'やっぼー'
    @puzzles = Puzzle.order(updated_at: :desc)
  end

  def create
    puzzle = Puzzle.new(status: :draft, challenge_level: @setting.challenge_level)
    puzzle.build_number
    puzzle.save!

    redirect_to puzzle_path(puzzle)
  end

  def show
    flash[:notice] = 'がんばろー'
  end

  def update
    new_answer_array = @puzzle.number.thinking_answer_array

    answer_params.each do |k, v|
      index = k.split('_').last.to_i
      new_answer_array[index] = k.blank? ? Number::BLANK_SYMBOL : v.to_i
    end

    status = (new_answer_array == @puzzle.number.correct_answer_array) ? :completed : status_param

    @puzzle.update!(status: status)
    @puzzle.number.update!(thinking_answer: new_answer_array.join)

    if @puzzle.draft?
      redirect_to puzzles_path
    elsif @puzzle.completed?
      flash[:success] = "completed"
      redirect_to puzzles_path
    else
      redirect_to puzzle_path(@puzzle)
    end
  end

  def reset
    @puzzle.update!(status: :draft)
    @puzzle.number.update!(thinking_answer: @puzzle.number.question)

    redirect_to puzzle_path(@puzzle)
  end

  def destroy
    @puzzle.destroy!

    redirect_to puzzles_path
  end

  private

  def set_puzzle
    @puzzle = Puzzle.find(params[:id])
  end

  def set_setting
    @setting = Setting.first # TODO: User ができたら current_user.setting にしたい
  end

  def answer_params
    permit_indexes = (0..80).to_a.map { |n| "index_#{n}".to_sym }
    params.require(:answer).permit(permit_indexes)
  end

  def status_param
    params.require(:status)
  end
end
