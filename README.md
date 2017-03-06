# Calculus in FORTRAN
## Description:
This FORTRAN77 program estimates area under a region beneath the functions *f(x) = 10/(x^2)* and *f(x) = (x^2) - 6x + 11*.

## Usage:
The program starts by prompting the user for a choice of which function to use. Invalid input exits the program with an error message, otherwise the user will be prompted to enter real values for ε (epsilon), the left-most x, and the right-most x.

The program displays the minimum number of intervals needed such that the difference between the upper and lower sums is less than or equal to ε, but if the region has been divided into more than 5000 intervals and the difference is still not within ε, the user will be alerted with a message. In either case, the two computed sums are displayed.