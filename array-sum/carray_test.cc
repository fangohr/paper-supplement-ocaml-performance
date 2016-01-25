#include <iostream>
#include <stddef.h>
#include <math.h>
#include <time.h>

static void
fill_ba(double* array, size_t n, double offset) {
  constexpr double pi = 4.0*atan(1.0);
  for (size_t i = 0; i < n; i++) {
    array[i] = sin((double)i*pi/(double)n + offset);
  }
}

static void
sum_ba(double* result, double* lhs, double* rhs, size_t n) {
  for (size_t i = 0; i < n; i++) {
    result[i] = lhs[i] + rhs[i];
  }
}

static double
norm_ba(double* a, size_t n) {
  double result = 0.0;
  for (size_t i = 0; i < n; i++) {
    result += a[i]*a[i];
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
  double* a = new double[n];
  double* b = new double[n];
  double* c = new double[n];
  double t0 = get_time();
  fill_ba(a, n, 1.5);
  fill_ba(b, n, 0.25);
  double t1 = get_time();
  sum_ba(c, a, b, n);
  double t2 = get_time();
  double diff = norm_ba(c, n);
  double t3 = get_time();
  std::cout << "Diff is " << diff << std::endl;
  std::cout << "Fill time " << t1 - t0 << "s" << std::endl;
  std::cout << " Sum time " << t2 - t1 << "s" << std::endl;
  std::cout << "Diff time " << t3 - t2 << "s" << std::endl;
  delete[] a;
  delete[] b;
  delete[] c;
  return 0;
}
