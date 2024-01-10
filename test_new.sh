#!/bin/bash

# 定义起始值、结束值和步长
start_i=5.4907
end_i=23.29
step_i=5

start_j=0.07847
end_j=24.30
step_j=5

# 使用while循环和bc进行浮点数循环
current_i=$start_i
while (( $(echo "$current_i <= $end_i" | bc -l) )); do
  current_j=$start_j
  while (( $(echo "$current_j <= $end_j" | bc -l) )); do
    
    p="$current_i,$current_j,21.785"
    q="$current_i,$current_j,95.256"
    dir_name="${current_i}-${current_j}"
    
    # 创建目录并复制ldos.in文件
    mkdir "$dir_name"
    cp ldos.in "$dir_name/ldos.in"
    
    # 修改ldos.in文件
    sed -i "7s/.*/$p/" "$dir_name/ldos.in"
    sed -i "8s/.*/$q/" "$dir_name/ldos.in"
    
    # 提交任务
    (cd "$dir_name" && sbatch mfn-DM.sh)
    
    # 更新j值
    current_j=$(echo "$current_j + $step_j" | bc)
  done
  
  # 更新i值
  current_i=$(echo "$current_i + $step_i" | bc)
done
