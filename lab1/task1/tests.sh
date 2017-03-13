#!/bin/bash
EXEC=prog
TEST_STR_1="Hello darkness, my old frient."
TEST_STR_1_ANS="hELLO DARKNESS, MY OLD FRIENT."
TEST_STR_2="And then he said, you all are fuckd up."
TEST_STR_2_ANS="aND THEN HE SAID, YOU ALL ARE FUCKD UP."
TEST_STR_3="What counts can't always be counted; What can be counted doesen't always count."
TEST_STR_3_ANS="wHAT COUNTS CAN'T ALWAYS BE COUNTED; wHAT CAN BE COUNTED DOESEN'T ALWAYS COUNT."
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
