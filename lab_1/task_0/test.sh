#!/bin/bash
TEST_STR_1="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
TEST_STR_2="AaBbCcDdEeFfGg"
TEST_STR_3="asdfNOnonOOJNon10240128120!@@#U*67asdASDAASDdas"
echo ------------------------------------------------
echo input:
echo $TEST_STR_1 
echo output:
echo $TEST_STR_1 | ./task_0
echo ------------------------------------------------
echo input: 
echo $TEST_STR_2    
echo output:
echo $TEST_STR_2 | ./task_0
echo ------------------------------------------------
echo input: 
echo $TEST_STR_3
echo output:
echo $TEST_STR_3 | ./task_0
echo ------------------------------------------------
