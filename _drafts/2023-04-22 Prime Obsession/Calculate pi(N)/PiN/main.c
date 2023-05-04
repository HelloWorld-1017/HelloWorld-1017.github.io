#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main() {
    unsigned long long int size = 1e6;
    unsigned long long int q = size/2;
    _Bool p[q];
    unsigned long long int nums = 0;

    // Initialize bool array
    for(unsigned long long int i=0;i<q;i++){p[i]=1;}

//    for(int i=0;i<q;i++)printf("%d ",p[i]);printf("\n");

    // Sieze of Eratosthenes
    for(unsigned long long int i=3;i<=sqrt(size);i+=2)
    {
        if(p[(i+1)/2-1])
            for(unsigned long long int k=((i*i+1)/2-1);k<=q-1;k+=i){p[k] = 0;}
    }

    for(unsigned long long int i=0;i<q;i++){
        if(p[i])
        {
//            printf("%d ",(i+1)*2-1);// 查一下find() function
            nums+=1;
        }
    }
    printf("\n %d",nums);
    getchar();
}

