class UhomikuziController < ApplicationController

  def index
    session.delete(:last_results)
  end

  def result
    times = params[:times].to_i
    times = 1 if times < 1

    results = times.times.map do
      number = rand(1..100)

      gorilla =
        case number
        when 49
          "？？？"
        when 99..100
          "金のゴリラ"
        when 94..98
          "銀のゴリラ"
        when 85..94
          "銅のゴリラ"
        when 70..84
          "3匹のゴリラ"
        when 50..69
          "2匹のゴリラ"
        else
          "1匹のゴリラ"
      end
      { number: number, result: gorilla }
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