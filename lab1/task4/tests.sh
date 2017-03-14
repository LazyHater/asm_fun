#!/bin/bash
EXEC=prog
TEST_STR_1="1024"
TEST_STR_1_ANS="400"
TEST_STR_2="4779"
TEST_STR_2_ANS="12ab"
TEST_STR_3="8742"
TEST_STR_3_ANS="2226"
TEST_STR_4="xddd"
TEST_STR_4_ANS="Invalid input!"
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
echo input: 
echo $TEST_STR_4 
echo output:
echo $TEST_STR_4 | ./$EXEC
echo expected:
echo $TEST_STR_4_ANS 
echo ------------------------------------------------
