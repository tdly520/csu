#include <stdio.h>

int gcd(int a, int b) {
    int temp;
    while (b != 0) {
        temp = a % b;
        a = b;
        b = temp;
    }
    return a;
}

int is_leap_year(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

int is_valid_date(int year, int month, int day) {
    int mon1[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int mon2[] = {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

    if (month < 1 || month > 12 || day < 1) return 0;
    if (is_leap_year(year)) {
        return day <= mon2[month];
    } else {
        return day <= mon1[month];
    }
}

void check_date(int mm, int dd, int a, int b, int c, int *kkk, int *mmm, int *ddd) {
    if (gcd(mm, dd) == a && (mm * dd) / a == b) {
        if (is_valid_date(c, mm, dd)) {
            if (*kkk == 0) {
                *mmm = mm;
                *ddd = dd;
            }
            (*kkk)++;
        }
    }
}

int main() {
    int t;
    while(scanf("%d", &t)!=EOF)
    {
    	
	
    
    for (int case_num = 1; case_num <= t; case_num++) {
        int a, b, c;
        scanf("%d%d%d", &a, &b, &c);

        int kkk = 0, mmm = 0, ddd = 0;
        for (int i = a; i <= b && i <= 12; i += a) {
            if ((a * b) % i == 0) {
                int day = (a * b) / i;
                if (day < 32) {
                    check_date(i, day, a, b, c, &kkk, &mmm, &ddd);
                }
            }
        }

        if (kkk > 1) {
            printf("Case #%d: 1\n", case_num);
        } else if (kkk == 1) {
            printf("Case #%d: %d/%02d/%02d\n", case_num, c, mmm, ddd);
        } else {
            printf("Case #%d: -1\n", case_num);
        }
    }
    return 0;
	}
}

