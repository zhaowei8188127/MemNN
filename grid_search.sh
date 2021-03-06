#!/bin/bash
export THEANO_FLAGS=device=cpu,floatX=float32

task=$1
if [[ -z $1 ]]; then
  task=3
fi

for embedding_size in 10 50 100 200 300 400 500 1000; do
  for lr in 0.1 0.01 0.001; do
    for gamma in 10 1 0.1 0.01 0.001; do
      echo "RUNNING task: $task, gamma: $gamma, embedding_size: $embedding_size, lr: $lr"
      time python -u main.py --task $task --embedding_size $embedding_size --gamma $gamma > results/q${task}_gamma${gamma}_lr${lr}_d${embedding_size}.txt &
      sleep 1
    done
    wait
  done
done
