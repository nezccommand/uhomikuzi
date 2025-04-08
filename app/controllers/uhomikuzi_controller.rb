class UhomikuziController < ApplicationController

  def index
    session.delete(:last_results)
  end

  def result
    times = params[:times].to_i
    times = 1 if times < 1 # to_iで0になった時用

    results = times.times.map do
      number = rand(1..100)

      gorilla =
        case number
        when 49
          "こむちゃん"
        when 99..100
          "金の🦍"
        when 94..98
          "銀の🦍"
        when 85..94
          "銅の🦍"
        when 70..84
          "🦍🦍🦍"
        when 50..69
          "🦍🦍"
        else
          "🦍"
      end
      { number: number, result: gorilla }
    end
    session[:last_results] = results
    redirect_to show_result_path
    
  end

  def show_result
    @results = session[:last_results]
    logger.debug "Results: #{@results.inspect}"

    unless @results
      redirect_to root_path, alert: "もう一度おみくじを引いてね！"
    end
  end
end