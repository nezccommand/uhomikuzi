module ApplicationHelper
  def rare_gorilla(results)
    rarity = {
      "？？？" => 6,
      "金" => 5,
      "銀" => 4,
      "銅" => 3,
      "3匹" => 2,
      "1匹" => 1
    }

    results.max_by{ |a| rarity[a['result']] }['result']
    # resultの中身をrarityに変換したものを比較し、最大のものを取り出し、最後に文字列に戻している
  end
end
