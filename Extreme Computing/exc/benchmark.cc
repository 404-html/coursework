#include <algorithm>
#include <cstdint>
#include <iostream>
#include <random>
#include <string>
#include <vector>

#include <err.h>
#include <sys/time.h>

// Return CPU usage, in seconds, since program start.
long double CPUTime() {
  struct timespec spec;
  if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &spec))
    err(1, "clock_gettime");
  return static_cast<long double>(spec.tv_sec) + static_cast<long double>(spec.tv_nsec) / 1000000000.0;
}

// Fill out with samples values uniformly sampled from [0, max].
void FillWithRandom(std::size_t max, std::size_t samples, std::vector<std::size_t> &out) {
  out.clear();
  std::default_random_engine generator;
  std::uniform_int_distribution<std::size_t> distribution(0, max);
  out.reserve(samples);
  for (std::size_t i = 0; i < samples; ++i) {
    out.push_back(distribution(generator));
  }
}

// Run a benchmark reading values from an array.
// length is the length of the array.
// samples is the number of random offsets to read
// sort_first indicates whether the random offsets should be sorted before the
//   benchmark (for semi-sequential access)
// Prints length, samples, sort_first, and the average time taken per sample.
void Benchmark(std::size_t length, std::size_t samples, bool sort_first) {
  // Create a vector filled with zeros.
  std::vector<char> vec(length);

  std::vector<std::size_t> reads;
  FillWithRandom(length - 1, samples, reads);

  if (sort_first) {
    std::sort(reads.begin(), reads.end());
  }

  // The actual benchmark.  Outputting the twiddle character forces the
  // compiler to execute this code instead of optimizing it away.
  char twiddle = '\n';
  double start = CPUTime();
  for (auto i : reads) {
    twiddle ^= vec[i];
  }
  // Compute average time per sample.
  long double time = (CPUTime() - start) / samples;
  // The twiddle character should still be a newline, so we'll use it as one.  
  std::cout << length << ' ' << samples << ' ' << (sort_first ? "sort" : "random") << ' ' << time << twiddle << std::flush;
}

int main(int argc, char *argv[]) {
  if (argc != 4) {
    std::cerr << "Usage: " << argv[0] << " length_of_array number_of_reads sort|random" << std::endl;
    return 1;
  }
  std::size_t length = std::stoull(argv[1]);
  std::size_t samples = std::stoull(argv[2]);
  std::string sorting(argv[3]);
  bool sort_first;
  if (sorting == "sort") {
    sort_first = true;
  } else if (sorting == "random") {
    sort_first = false;
  } else {
    std::cerr << "The last argument should be \"sort\" or \"random\"." << std::endl;
    return 2;
  }
  if (length + sizeof(std::size_t) * samples > (1 << 31)) {
    std::cerr << "To prevent machines from crashing, we won't let you run benchmarks that use > 2GB RAM." << std::endl;
    return 3;
  }
  Benchmark(length, samples, sort_first);
}
