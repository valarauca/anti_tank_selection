

function HitTopLevel(roll,hit,rr,meph) = if hit<=roll then (1 + (if meph=1 & roll=6 then (call MephritSequence(1 d6, hit, rr)) else(0))) else ( if rr=1 & roll=1 then (call RROneToHit(1 d6, hit, rr, meph)) else (0))

function RROneToHit(roll, hit, rr, meph) = if hit<=roll then (if meph=1 & roll=6 then (1+(call MephritSequence(1 d6, hit, rr))) else (1) ) else (0)

function MephritSequence(roll, hit, rr) = if hit<=roll then (1) else (if rr=1 & roll=1 then ( call HitCheck(1 d6, hit) ) else (0))

function HitCheck(roll,hit) = if hit<=roll then 1 else 0

\ WoundCheck
\    Basic comparison, did we wound?
\
function WoundCheck(roll,wound) = if wound<=roll then 1 else 0

\ SaveCheck
\    Basic comparison, did we damage them?
\
function SaveCheck(roll,save) = if save<=roll then 0 else 1

\ Damage
\     Generates a high power / low power option
\
function Damage(highPower) = if highPower=1 then (sum 1 d6) else (sum 1 d3)

\ need to do some crazy stuff for the moral wounds
\
\ (woundRoll := ( sum (sum 3 d3)#call HitTopLevel( 1 d6, HitOn, ReRollOneToHit, Mephrit)) d6; (sum (sum (count WoundOn<=woundRoll)#call SaveCheck(1 d6, SaveOn))#call Damage(FullPower)) + (count 6=woundRoll) )

count 6=(( sum (sum 3 d3)#call HitTopLevel( 1 d6, HitOn, ReRollOneToHit, Mephrit)) d6)
