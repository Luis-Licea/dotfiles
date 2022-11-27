#!/usr/bin/awk -f
BEGIN {
    # FS=','
    sum=0
    print "sum is: " sum
}

NR == 1 {
    print "First record."
    print $1
    next
}

/^$/ {
    print "Empty line."
}

/[0-9]+/ {
    sum+=$1
}

/[a-zA-Z]+/ {
    print "This is a string."
}

END {
    print "sum is: " sum
    if (sum > 0) {
        print "Sum " sum " is greater than 0"
    }
}
