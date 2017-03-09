#!/bin/bash
EXEC=task_2
TEST_STR_1="aaaa"
TEST_STR_1_ANS="43690"
TEST_STR_2="1234"
TEST_STR_2_ANS="4660"
TEST_STR_3="24ab"
TEST_STR_3_ANS="9387"
echo ------------------------------------------------
echo input:
echo "$TEST_STR_1 ($TEST_STR_1_ANS)" 
echo output:
echo $TEST_STR_1 | ./$EXEC 
echo ------------------------------------------------
echo input: 
echo "$TEST_STR_2 ($TEST_STR_2_ANS)"  
echo output:
echo $TEST_STR_2 | ./$EXEC
echo ------------------------------------------------
echo input: 
echo "$TEST_STR_3 ($TEST_STR_3_ANS)"
echo output:
echo $TEST_STR_3 | ./$EXEC
echo ------------------------------------------------
