#!/bin/bash

student=$1

week=week10
src_dir=/Users/kyclark/work/abe487/lab/week08
in_dir=/Users/kyclark/work/students
dirs=$(find $in_dir -mindepth 1 -maxdepth 1 -type d | grep -v meta)

i=0
for dir in $dirs; do
  if [[ -n $student ]] && [[ $(basename $dir) != $student ]]; then
    continue
  fi

  test_dir=$dir/$week
  if [[ -d $test_dir ]]; then
      let i++
      printf "%5d: %s\n" $i $dir
      #cp $src_dir/*.{txt,fa} $test_dir
      #./tester.pl -d $test_dir -t ${week}.conf > $test_dir/test-out 2>&1
      ./test-week10.pl -d $test_dir > $test_dir/test-out 2>&1
      cd $test_dir
      git add test-out
      git commit -m 'week10 test-out' test-out
      git push
      cd -
  else
      echo \"$test_dir\" does not exist
  fi
done
