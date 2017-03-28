#!/bin/bash
EXEC=prog
TEST_STR_1="-e \x41\x00\xff"
TEST_STR_1_ANS="41 00 ff "
TEST_STR_2=""
TEST_STR_2_ANS=""
TEST_STR_3=""
TEST_STR_3_ANS=""
echo ------------------------------------------------
echo input:
echo $TEST_STR_1 
echo output:
echo $TEST_STR_1 | ./$EXEC 
echo expected:
echo $TEST_STR_1_ANS 
echo ------------------------------------------------
echo input: 
echo $TEST_STR_2   
echo output:
echo $TEST_STR_2 | ./$EXEC
echo expected:
echo $TEST_STR_2_ANS 
echo ------------------------------------------------
echo input: 
echo $TEST_STR_3 
echo output:
echo $TEST_STR_3 | ./$EXEC
echo expected:
echo $TEST_STR_3_ANS 
echo ------------------------------------------------
