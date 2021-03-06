class CharacteristicsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  authorize_resource

  def index
    @users = User.all
  end

  def edit
    @characteristic = user.characteristic
  end

  def update
    user.characteristic.update(characteristic_params)
    @characteristic = user.characteristic
  end

  def show
    redirect_to root_path unless current_user&.admin? || cookies[:parent]

    user

    @chart = Gchart.line(  size: '1000x300',
                          title: "График успеваемости",
                          bg: 'white',
                          bar_colors: '3f8ed9',
                          legend: 'количество набранных баллов по ЕГЭ',
                          axis_with_labels: [['x'], ['y']],
                          min_value: 0,
                          max_value: 100,
                          data: progress_points,
                          labels: progress_date
    )

    authorize! :read, Characteristic
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def progress_points
    user.progresses.pluck(:points)
  end

  def progress_date
    user.progresses.pluck(:date)
  end

  def characteristic_params
    params.require(:characteristic).permit(:description)
  end
end
