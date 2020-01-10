
\ HitRROne
\    Top Level Hit Function, determines if a dice should be re-rolled.
\    Re-Rolls are controlled by setting the `rr=1`.
\    Re-Rolls only occur if/when `roll=1`.
\
function HitRROne(roll,hit,rr,meph) = if rr=1 & roll=1 then call MephHitCheck(1 d6, hit, rr, meph) else call MephHitCheck(roll, hit, rr, meph)

\ MephHitCheck
\    If the `roll=6` and `meph=1` this will generate an additional hit,
\    the additional hit will not generate any more additional hits.
\
function MephHitCheck(roll,hit,rr,meph) = if meph=1 & roll=6 then (call HitCheck(roll, hit)+call HitRROne(1 d6, hit,rr,0)) else call HitCheck(roll, hit)

\ HitCheck
\    If the `hit<=roll` it returns 1
\    otherwise it returns 0
\
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
woundRoll := ( sum (sum 3 d3)#call HitRROne( 1 d6, HitOn, ReRollOneToHit, Mephrit)) d6;
mortalWounds := count 6=woundRoll;
(sum (sum (count WoundOn<=woundRoll)#call SaveCheck(1 d6, SaveOn))#call Damage(FullPower)) + mortalWounds

