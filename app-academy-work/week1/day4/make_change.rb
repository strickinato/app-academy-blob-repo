def make_change_american(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  
  if amount >= coins.first
    make_change(amount - coins.first, coins) << coins.first
  else
    make_change(amount, coins.drop(1))
  end
end

def make_change(amount, coins = [25, 10, 5, 1])
  current_best = make_change_american(amount, coins)
  
  (coins.length-1).times do |max_coin|   
    potential_best = make_change_american(amount, coins.drop(max_coin))
    if potential_best.length < current_best.length
      current_best = potential_best
    end
  end
  
 current_best
end



p make_change(2, [10, 7, 1])