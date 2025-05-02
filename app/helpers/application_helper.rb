module ApplicationHelper
  def rare_gorilla(results)
    rarity = {
      "？？" => 6,
      "金" => 5,
      "銀" => 4,
      "銅" => 3,
      "3匹" => 2,
      "1匹" => 1
    }

    results.max_by { |a| rarity[a["result"]] }["result"]
  end

  RARITY = ["？？", "金", "銀", "銅", "3匹", "1匹"].freeze

  def count_rarity(results)
    counts = results.map { |r| r["result"] }.tally
  
    output = []
    RARITY.each do |gorilla|
      count = counts[gorilla]
      if count
        output << [gorilla, count]
      end
    end
  
    output
  end
end
