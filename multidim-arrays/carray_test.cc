#include <iostream>
#include <stddef.h>
#include <math.h>
#include <time.h>

static constexpr double pi = 4.0*atan(1.0);
static constexpr int d = 3;

typedef double Tensor[d][d][d];

static void
init_tensors(Tensor* tensors, size_t n) {
  double fd3 = d*d*d;
  double omega = 0.2*pi;
  for (size_t i = 0; i < n; i++) {
    double x = (double)i/(double)n;
    for (int j = 0; j < d; j++) {
      for (int k = 0; k < d; k++) {
        for (int l = 0; l < d; l++) {
          /*
           * dx goes from 0 to 1 while going through the tensor components.
           * x goes from 0 to 1 while going from first to last tensor.
           */
          double dx = (double)(l + (k + j*d)*d) / fd3;
          tensors[i][j][k][l] = sin(omega*(x + dx));
        }
      }
    }
  }
}

double sum_all(Tensor* tensors, size_t n) {
  double result = 0.0;
  for (size_t i = 0; i < n; i++) {
    for (int j = 0; j < d; j++) {
      for (int k = 0; k < d; k++) {
        for (int l = 0; l < d; l++) {
          double v = tensors[i][j][k][l];
          result += v*v;
        }
      }
    }
  }
  return sqrt(result/((double)(n*d*d*d)));
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
  constexpr size_t n = 1000*1000;
  double t0 = get_time();
  Tensor* tensors = new Tensor[n];
  double t1 = get_time();
  init_tensors(tensors, n);
  double t2 = get_time();
  double result = sum_all(tensors, n);
  double t3 = get_time();
  std::cout << "Sum is " << result << std::endl;
  std::cout << "Create time " << t1 - t0 << " s" << std::endl;
  std::cout << "  Init time " << t2 - t1 << " s" << std::endl;
  std::cout << "   Sum time " << t3 - t2 << " s" << std::endl;
  delete[] tensors;
  return 0;
}
