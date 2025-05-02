class UhomikuziController < ApplicationController
  def index
    session.delete(:last_results)
  end

  def result
    times = [ [ params[:times].to_i, 100 ].min, 1 ].max

    results = times.times.map do
      number = rand(1..100)

      gorilla =
        case number
        when 100
          "？"
        when 98..99
          "金"
        when 93..97
          "銀"
        when 85..94
          "銅"
        when 60..84
          "3匹"
        else
          "1匹"
        end
      { result: gorilla }
    end
    session[:last_results] = results
    redirect_to show_result_path
  end

  def show_result
    @results = session[:last_results]

    unless @results
      redirect_to root_path, alert: "もう一度おみくじを引いてね！"
    end
  end
end
