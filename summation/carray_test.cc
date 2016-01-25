#include <iostream>
#include <stddef.h>
#include <math.h>
#include <time.h>

static constexpr double pi = 4.0*atan(1.0);

static double
mysin(double x) {
  x -= floor(x/pi)*pi;
  return x - x*x*x/6.0 + x*x*x*x*x/120.0 - x*x*x*x*x*x*x/5040.0;
}

static double
sum_ba(double offset1, double offset2, size_t n) {
  double result = 0.0;
  for (size_t i = 0; i < n; i++) {
    double a1 = mysin((double)i*pi/(double)n + offset1);
    double a2 = mysin((double)i*pi/(double)n + offset2);
    result += (a1 + a2)*(a1 + a2);
  }
  return sqrt(result/(double)n);
}

static double
get_time() {
  struct timespec ts;
  if (clock_gettime(CLOCK_REALTIME, &ts) != 0) {
    abort();
  }
  return ts.tv_sec + ts.tv_nsec*1e-9;
}

int
main() {
  constexpr size_t n = 50*1000*1000;
  double t1 = get_time();
  double diff = sum_ba(1.5, 0.25, n);
  double t2 = get_time();
  std::cout << "Diff is " << diff << std::endl;
  std::cout << "Sum time " << t2 - t1 << "s" << std::endl;
  return 0;
}
