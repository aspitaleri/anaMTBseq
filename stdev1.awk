{
  x1 += $1
  x2 += $1*$1
}
END {
  x1 = x1/NR
  x2 = x2/NR
  sigma = sqrt(x2 - x1*x1)
  variance = (x2 - x1*x1)
  if (NR > 1) std_err = sigma/sqrt(NR -1)
#  printf "%10s %6s %4s %6s\n", "Npoints","Mean","STD","STE"
#  printf "%18d %8.2f %6.2f %6.2f \n", NR,x1,sigma,std_err
#  printf "%8d %6.2f %6.2f %8.2f %6.2f\n", NR,x1,sigma,std_err,variance
  printf "%6.2f\n", x1
}

