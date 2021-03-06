#!/usr/bin/env bash

if [[ -z $ROOT_DIR || -z $MCANDOCK_LOCATION ]]
then
    echo "You must define \$ROOT_DIR and \$MCANDOCK_LOCATION."
    echo "Be sure to *export* these variables!"
    exit
fi

program=$1
shift

number=$1
shift

echo qsub -d . $ROOT_DIR/scripts/$program $@
my_depend=`qsub -d . $ROOT_DIR/scripts/$program $@`

for i in `seq 2 $number`
do
    my_depend=`qsub -d . $ROOT_DIR/scripts/$program -W depend=after:$my_depend $@`
done
