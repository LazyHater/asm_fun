#!/bin/bash
EXEC=prog
TEST_STR_1="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
TEST_STR_1_ANS="FGHIJKLMNOPQRSTUVWXYZABCDE"
TEST_STR_2="AaBbCcDdEeFfGg"
TEST_STR_2_ANS="FaGbHcIdJeKfLg"
TEST_STR_3="asdfNOnonOOJNon10240128120!@@#U*67asdASDAASDdas"
TEST_STR_3_ANS="asdfSTnonTTOSon10240128120!@@#Z*67asdFXIFFXIdas"
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
