C area.f
C - Nathan Morse -
C Description: This program finds the area under a curve defined by a
C function by calculating the sum of the areas of rectangular subregions
C of the curve. These sums are the upper and lower sums of the curve.
C The best estimate of the true area can be found when the upper sum is
C closest in value to the lower sum, which is determined by epsilon, so
C as epsilon decreases, the estimated area becomes much closer to the
C true area. The two functions that define curves in this program are:
C function 1: f(x) = 10 / x² and function 2: f(x) = x² - 6x + 11.
C Input: The program prompts the user for a choice of function 1, or 
C function 2. If an invalid choice is given, then the program will exit
C with an error message. Otherwise, the program will prompt for a value
C for epsilon, the left-most x point, and then the right-most x point,
C which are all real numbers.
C Output: The program will display the mininum number of intervals
C needed such that the difference between the lower and upper sum is
C less than or equal to epsilon. If the region was divided into more
C than 5000 intervals and the difference is not within epsilon, an
C according message will be displayed. Both the upper and lower sum will
C always be displayed.
C
C234567
C     Prompt user for choice of function 1 or 2:
      integer choice, intervals
      real left, right, epsilon, epsilonCalc
      real calcLowerSum, calcUpperSum, lowerSum, upperSum
C     formatting for printing of sums allows only 4 digits after decimal
 100  format (A, F20.4)
C
      print *, "Function 1: f(x) = 10 / x²"
      print *, "Function 2: f(x) = x² - 6x + 11"
      print *, "Type 1 to use function 1 or 2 for function 2:"
      read *, choice ! prompt user for choice of function
      if (choice .ne. 1 .and. choice .ne. 2) then
         print *, "ERROR: invalid choice!" ! invalid input!
         stop ! end the program
      endif
C     prompt user for epsilon, left and right-most x point
      print *, "Enter desired epsilon value:"
      read *, epsilon
      print *, "Enter left-most axis value:"
      read *, left
      print *, "Enter right-most axis value:"
      read *, right
C     start with the first interval and calculate sums
      intervals = 1
      lowerSum = calcLowerSum (choice, intervals, left, right)
      upperSum = calcUpperSum (choice, intervals, left, right)
      epsilonCalc = upperSum - lowerSum ! current calculated difference
C     convert calculated difference to positive real if negative
 20   if (epsilonCalc .lt. 0) then
         epsilonCalc = - epsilonCalc
      endif
C     calculated difference must be greater than epsilon and the
C     number of intervals must be less than 5000 for this if statement
C     to pass.
 30   if (intervals .le. 5000 .and. epsilonCalc .gt. epsilon) then
         intervals = intervals + 1
         lowerSum = calcLowerSum (choice, intervals, left, right)
         upperSum = calcUpperSum (choice, intervals, left, right)
         epsilonCalc = upperSum - lowerSum
         goto 20 ! converts negative difference and makes this if a loop
      endif
      if (intervals .gt. 5000) then ! more than 5000 intervals
         print *, "The region is divided into more than 5000 intervals"
         print *, "and the difference is not within epsilon."
         write (*, 100) " The upper sum is:", upperSum ! uses format
         write (*, 100) " The lower sum is:", lowerSum
      else ! intervals didn't surpass 5000 and diff is within epsilon
         write (*, 100) " The upper sum is:", upperSum
         write (*, 100) " The lower sum is:", lowerSum
         print *, "The number of intervals needed is:", intervals
      endif
      end
C     ------------------------------------------------------------------
C     function to calculate the lower sum of areas.
C     Precondition: the user's function choice as well as number of 
C     intervals, left-most and right-most x point are parameters.
C     Postcondition: the lower sum of the area under the curve is
C     calculated and returned.
      real function calcLowerSum (choice, intervals, left, right)
      integer choice, intervals
      real left, right
      real rectWidth, rectSums, startingPoint, function1, function2
      rectSums = 0.0 ! sum of areas of rectangle(s) starts at 0
      rectWidth = (right - left) / intervals ! width of rectangle
      startingPoint = left ! start at left x point
C
      do 40 i = 1, intervals, 1 ! for every interval
         if (choice .eq. 1) then ! function 1 is used
            function1 = 10 / startingPoint**2 ! f(x) = 10 / x²
            rectSums = rectSums + rectWidth * function1 ! area of rect
         else ! function 2 is used:  f(x) = x² - 6x + 11
            function2 = startingPoint**2 - 6 * startingPoint + 11
            rectSums = rectSums + rectWidth * function2
         endif
C        increment starting point to go to next rectangle
         startingPoint = startingPoint + rectWidth
   40 continue
      calcLowerSum = rectSums ! return the lower sum
      return
      end
C     ------------------------------------------------------------------
C     this function works in the same manner as calcLowerSum but it
C     instead calculates the upper sum.
C     Precondition: the user's function choice as well as number of 
C     intervals, left-most and right-most x point are parameters.
C     Postcondition: the upper sum of the area under the curve is
C     calculated and returned.
      real function calcUpperSum (choice, intervals, left, right)
      integer choice, intervals
      real left, right
      real rectWidth, rectSums, startingPoint, function1, function2
      rectSums = 0.0
      rectWidth = (right - left) / intervals 
      startingPoint = right ! start at right x point
C
      do 50 i = 1, intervals, 1
         if (choice .eq. 1) then
            function1 = 10 / startingPoint**2
            rectSums = rectSums + rectWidth * function1
         else
            function2 = startingPoint**2 - 6 * startingPoint + 11
            rectSums = rectSums + rectWidth * function2
         endif
         startingPoint = startingPoint - rectWidth
   50 continue
      calcUpperSum = rectSums
      return
      end
