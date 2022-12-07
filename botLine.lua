local function newMove(i,j,rate)
  return{
  i = i,
  j = j,
  rate = rate,
}
end


function compMoveLine(whoseMovelocal, ...)
  
  local bestMove = newMove(1,1,-10000)
  
  toCopy = ...
  local arr= deepcopy(toCopy)
  opponent = turnMoveVirtual(whoseMovelocal)
  a = math.ceil(fieldSize/2)
  if(arr[a][a].owner==0) then -- take centre
    bestMove = newMove(a,a, score)
    return {bestMove.i,bestMove.j}
  end
  
  
  
  
    
  return {bestMove.i,bestMove.j}
end


function moveToWin(i, j , whoseMoveLocal, ...)
  toCopy = ...
  local arr  = deepcopy(toCopy)
  arr[i][j].owner = whoseMoveLocal
  local winner = isWinn(arr)
  
  if winner == whoseMoveLocal then
    return true
  else return false
  end
end
