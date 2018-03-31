#include  <stdio.h>

int  gcd(int a, int b) {
	if(b == 0) {
		return a;
	}
	 else {
		return  gcd(b, a % b);
	}
}

int  main() {
	int a, b, res;

	printf("Enter  two  integers: ");
	scanf("%d %d", &a, &b);

	res = gcd(a, b);

	printf("The  GCD of %d and %d is %d.\n", a, b, res);
	return  0;
}
