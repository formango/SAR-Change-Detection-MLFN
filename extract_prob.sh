#!/usr/bin/env sh
/bin/bash  bin/pyspark
 
 cat result.txt | grep "Batch ., prob" | awk '{print $9}' >& temp1.txt && 
 cat result.txt | grep "Batch .., prob" | awk '{print $9}' >& temp2.txt && 
 cat result.txt | grep "Batch ..., prob" | awk '{print $9}' >& temp3.txt && 
 cat result.txt | grep "Batch ...., prob" | awk '{print $9}' >& temp4.txt && 
 cat result.txt | grep "Batch ....., prob" | awk '{print $9}' >& temp5.txt
 
 cat temp5.txt >> temp4.txt && 
 cat temp4.txt >> temp3.txt && 
 cat temp3.txt >> temp2.txt && 
 cat temp2.txt >> temp1.txt && 
 cat temp1.txt >> prob.txt

