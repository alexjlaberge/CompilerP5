#!/bin/bash

INFILES=`ls samples/*.decaf | sed -e 's/\.decaf//'`
CURRENT_OUTPUT="/tmp/eecs483p4.out"

function spim_run() {
        if [ -f ${1}.in ]
        then
                solution/spim -keepstats -file ${1}.s < ${1}.in > ${1}.out
        else
                solution/spim -keepstats -file ${1}.s > ${1}.out
        fi
}

function dcc_run() {
        ./dcc < ${1}.decaf > ${1}.s #2> /dev/null
        spim_run ${1}
        cp ${1}.out ${CURRENT_OUTPUT}

        ./solution/dcc < ${1}.decaf > ${1}.s 2> /dev/null
        spim_run ${1}
}

make || exit 1

if [ ! -z "${1}" ]
then
        input="samples/${1}"
        dcc_run ${input}
        diff -aw ${input}.out ${CURRENT_OUTPUT}
        exit $?
fi

for input in ${INFILES}
do
        echo -ne "Testing ${input}..."

        dcc_run ${input}

        diff -awq ${input}.out ${CURRENT_OUTPUT} && echo "PASS"
        if [ ! "$?" -eq 0 ]
        then
                FAILED="${FAILED} ${input}"
        fi
done

echo
echo "Failures:"

for failure in ${FAILED}
do
        echo "    ${failure}"
done
