rm p2
#./testsTypeI.sh 1 2 0 0 0  >& q3 &
#wait
# one block known phase
./testsDiff.sh 1 2 0 0 0  >> p2 &
#wait
#./testsTypeI.sh 1 1 0  >& p2 &
#two blocks, unknown phase, EM-freq
#./tests.sh 0 0 2 >& r &
#wait
#./testsTypeI.sh 0 0 2 >& r2 &
#wait
# one block unknown phase, EM-freq
#./tests.sh 1 0 2  >& s &
#wait
#./testsTypeI.sh 1 0 2  >& s2 &



