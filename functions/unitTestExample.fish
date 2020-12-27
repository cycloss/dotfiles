startTests names
set names 'ted' 'hugo' 'pet' 'jam'
set names2 'ted2' 'hugo2' 'pet' 'jam'
set names3 'jamie' 'rupert'
set names4 'jamie' 'rupert'
assertEquals names names2
assertEquals names3 names4
endTests

startTests basic
set out (./test ted hugo rup)
set expected '1: ted' '2: hugo' '3: rup'
assertEquals out expected
endTests