class Services::CharacteristicChangeService

  def initialize(user, request, new_points, path, **test)
    @user = user
    @request = request
    @new_points = new_points
    @path = path
    @test = test[:test]
  end

  def change
    case @request
    when 'topics'

      score_for_topic
    when 'essay_passages'
      score_for_essay_passage
    when 'tests'
      score_for_test
    end

    change_rank
    Services::SendNotificationService.new("Вы получили новые очки!", @path, @user, @user, type: 'points').send if @request != 'tests'
  end

  private

  def score_for_topic
    points = @user.characteristic.points
    points += @new_points*2
    @user.characteristic.update(points: points)
  end

  def score_for_essay_passage
    points = @user.characteristic.points
    points += @new_points.to_i*4
    @user.characteristic.update(points: points)
  end

  def score_for_test
    points = @user.characteristic.points
    points += @new_points*2
    points += count_bonus_points if @test

    @user.characteristic.update(points: points)
  end

  def count_bonus_points
    # It is bonus for success test

    all_points = @test.all_points
    right_percent = ((100/all_points.to_f)*@new_points).floor

    if right_percent < 50
      0
    elsif right_percent >= 50 && right_percent < 60
      @new_points
    elsif right_percent >= 60 && right_percent < 70
      @new_points*1.3
    elsif right_percent >= 70 && right_percent < 80
      @new_points*1.5
    elsif right_percent >= 80 && right_percent < 90
      @new_points*2
    elsif right_percent >= 90 && right_percent < 99
      @new_points*3
    else
      @new_points*5
    end
  end

  def change_rank
    points = @user.characteristic.points

    rank = if    points >= 50 && points < 100
             'Ефрейтор'
           elsif points >= 101 && points < 150
             'Младший сержант'
           elsif points >= 151 && points < 200
             'Сержант'
           elsif points >= 201 && points < 250
             'Старший сержант'
           elsif points >= 251 && points < 300
             'Старшина'
           elsif points >= 301 && points < 350
             'Прапорщик'
           elsif points >= 351 && points < 400
             'Старший прапорщик'
           elsif points >= 401 && points < 450
             'Лейтенант'
           elsif points >= 451 && points < 500
             'Старший лейтенант'
           elsif points >= 501 && points < 550
             'Капитан'
           elsif points >= 551 && points < 600
             'Майор'
           elsif points >= 601 && points < 650
             'Подполковник'
           elsif points >= 651 && points < 700
             'Полковник'
           elsif points >= 701 && points < 750
             'Генерал-майор'
           elsif points >= 751 && points < 800
             'Генерал-лейтенант'
           elsif points >= 801 && points < 850
             'Генерал-полковник'
           elsif points >= 851 && points < 900
             'Генерал-армии'
           elsif points >= 901 && points < 950
             'Генерал-маршал'
           elsif points >= 951 && points < 1000
             'Верховный главнокомандующий'
           elsif points >= 1001 && points < 1050
             'Император'
           elsif points >= 1051 && points < 1100
             'Глава планеты'
           elsif points >= 1101 && points < 1150
             'Глава системы'
           elsif points >= 1151 && points < 1200
             'Глава галактики'
           elsif points >= 1201 && points < 1250
             'Глава группы галактик'
           elsif points >= 1251 && points < 1300
             'Глава вселенной'
           elsif points >= 1301
             'Предиктор-корректор'
           end

    @user.characteristic.update(rank: rank) if rank
  end
end
