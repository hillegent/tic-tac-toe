-- recursion

require ("botLine")


function newMove(i,j,rate)
  return{
  i = i,
  j = j,
  rate = rate,
}
end


function compMove(whoseMovelocal, ...)
  
  local bestMove = newMove(1,1,-10000)
  
  toCopy = ...
  local arr= deepcopy(toCopy)
  opponent = turnMoveVirtual(whoseMovelocal)
  a = math.ceil(fieldSize/2)
  if(arr[a][a].owner==0) then 
    bestMove = newMove(a,a, score)
    return {bestMove.i,bestMove.j}
  end
  
  for i=1, fieldSize, 1 do -- one move to win
    for j=1,fieldSize,1 do
      if arr[i][j].owner == 0 then
        b = moveToWin(i,j, whoseMovelocal,arr)
        if b then
          bestMove = newMove(i,j, score)
          return {bestMove.i,bestMove.j}
        end
      end
    end
  end
  
  for i=1, fieldSize, 1 do -- one move to lose
    for j=1,fieldSize,1 do
      if arr[i][j].owner == 0 then
        b = moveToWin(i,j, opponent,arr)
        if b then
          bestMove = newMove(i,j, score)
          return {bestMove.i,bestMove.j}
        end
      end
    end
  end
  
  isPossible = true
    -- check right diagonal
    for i = 1, fieldSize, 1 do
      if  arr[i][fieldSize - i + 1].owner == 0 or arr[i][fieldSize - i + 1].owner == whoseMovelocal then 
        else
          isPossible = false
       end
     end
      if isPossible then
        for i = 1, fieldSize, 1 do
          if  arr[i][fieldSize - i + 1].owner == 0 then 
            bestMove = newMove(i,fieldSize - i + 1, score)
            return {bestMove.i,bestMove.j}
          end
        end
      end
      
  isPossible = true
  -- check left diagonal
  for i = 1, fieldSize, 1 do
      if  arr[i][i].owner == 0 or arr[i][i].owner == whoseMovelocal then 
        else
          isPossible = false
       end
     end
      if isPossible then
        for i = 1, fieldSize, 1 do
          if  arr[i][i].owner == 0 then 
            bestMove = newMove(i,i, score)
            return {bestMove.i,bestMove.j}
          end
        end
      end
  
  isPossible = true
  -- check lines
  for i = 1, fieldSize, 1 do 
    for j = 1, fieldSize , 1 do
      if arr[i][j].owner == whoseMovelocal or arr[i][j].owner == 0 then 
        else
          isPossible = false
        end
    end
    if isPossible then
        for j = 1, fieldSize, 1 do
          if  arr[i][j].owner == 0 then 
            bestMove = newMove(i,j, score)
            return {bestMove.i,bestMove.j}
          end
        end
      end
    isPossible = true  
  end
  
  isPossible = true
  
  for j = 1, fieldSize, 1 do -- check colums
    for i = 1, fieldSize -1, 1 do
      if arr[i][j].owner == whoseMovelocal or arr[i][j].owner == 0 then 
        else
          isPossible = false
        end
    end
    if isPossible then
        for i = 1, fieldSize, 1 do
          if  arr[i][j].owner == 0 then 
            bestMove = newMove(i,j, score)
            return {bestMove.i,bestMove.j}
          end
        end
      end
    isPossible = true   
  end
  
  
  for i=1, fieldSize, 1 do -- recursion
    for j=1,fieldSize,1 do
      if arr[i][j].owner == 0 then
        score = minMax(i,j, opponent, 0, 0 ,arr)
        if bestMove.rate < score then
          bestMove = newMove(i,j, score)
        end
      end
    end
  end
    
  return {bestMove.i,bestMove.j}
end

function turnMoveVirtual(whoseMovelocal)
  if(whoseMovelocal == 1) then
    Movelocal = 2
  else
    if (whoseMovelocal == 2) then 
      Movelocal = 1
    end
  end
  return Movelocal
end


function minMax(i, j , whoseMoveLocal, depth, rate , ...)
  depth = depth +1
  
  local score = rate + 0
  toCopy = ...
  local arr  = deepcopy(toCopy)
  arr[i][j].owner = whoseMoveLocal
  local winner = isWinn(arr)
  
  if winner == whoseMove then
    score = score + 10 - depth
  end
  opponent = turnMoveVirtual(whoseMoveLocal)
  if winner == opponent then
    score = score - 10 + depth
  end
  if winner == 3 then
    score = score + 0
  end
  if depth > 5 then 
    return 0
  end
  if winner == 0 then 
    for i=1, fieldSize, 1 do
      for j=1,fieldSize,1 do
        if arr[i][j].owner == 0 then
          score = score + minMax(i,j, opponent, depth, score ,arr)
        end
      end
    end
  end
  return score
end

function isWinn(...)
  local virtualField =  ...
  local winner = 0
  freevirtualField = 0
  for i = 1, fieldSize, 1 do 
    for j = 1, fieldSize, 1 do
      if virtualField[i][j].owner == 0 then
        freevirtualField = freevirtualField +1
      end
    end
  end
  
  if freevirtualField == 0 then 
    winner = 3
  end
  
    local win
  notChanged = true
  -- check lines
  for i = 1, fieldSize, 1 do 
    for j = 1, fieldSize-1, 1 do
      if virtualField[i][j].owner == virtualField[i][j+1].owner then 
        win = virtualField[i][j].owner
        else
          notChanged = false
        end
    end
    if not(win ==0) and notChanged then
      winner = win
      break end
    notChanged = true  
  end
  
  for j = 1, fieldSize, 1 do -- check colums
    for i = 1, fieldSize -1, 1 do
      if virtualField[i][j].owner == virtualField[i+1][j].owner then 
        win = virtualField[i][j].owner
        else
          notChanged = false
        end
    end
    if not(win ==0) and notChanged then
      
      winner = win
      break end
    notChanged = true  
  end
  
  -- check right diagonal
  for i = 1, fieldSize -1, 1 do
      if  virtualField[i][fieldSize - i + 1].owner == virtualField[i+1][fieldSize - i].owner then 
        win = virtualField[i][fieldSize - i + 1].owner
        else
          notChanged = false
        end
  end
      if not(win ==0) and notChanged then
        winner = win
      end
  notChanged = true  
  
  -- check left diagonal
  for i = 1, fieldSize -1, 1 do
      if  virtualField[i][i].owner == virtualField[i+1][i+1].owner then 
        win = virtualField[i][i].owner
        else
          notChanged = false
        end
  end
      if not(win ==0) and notChanged then
        winner = win
      end
  notChanged = true 
  
  return winner
end