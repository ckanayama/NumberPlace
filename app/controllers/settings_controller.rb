class SettingsController < ApplicationController
  before_action :set_setting, only: [:edit, :update]

  def edit; end

  def update
    @setting.update!(setting_params)

    flash[:notice] = "更新したよ！"
    redirect_to root_path
  end

  private

  def set_setting
    @setting = Setting.first # TODO: User ができたら current_user.setting にしたい
  end

  def setting_params
    params.require(:setting).permit(:challenge_level, :theme)
  end
end
