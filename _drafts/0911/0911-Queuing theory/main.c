#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<stdbool.h>
#define MAXCAR 60 //Maximum queue length
#define	MIN_PER_HR 60.0

typedef struct item
{
	long Arrive;
	int BordingTime;
}Item;

typedef struct node
{
	Item item;
	struct node* Next;
}Node;

typedef struct queue
{
	Node* front;
	Node* rear;
	int items;
}Queue;


void InitializeQueue(Queue* pq);
int QueueIsFull(const Queue* pq);
int QueueIsEmpty(const Queue* pq);
int QueueItemCount(const Queue* pq);
int EnQueue(Item item, Queue* pq);
int DeQueue(Item* pitem, Queue* pq);
void EmptyTheQueue(Queue* pq);

static void CopyToNode(Item item, Node* pn);
static void CopyToItem(Node* pn, Item* pi);

int NewCar(double x);
Item Cartime(long when);
double Average(double Ave[], int n);

// main
int main(void)
{
	Queue Line;
	Item Temp;
	double Hours;// 模拟小时数
	int Perhour;//每小时平均来多少辆出租车
	int Cycle;
	double CycleLimit;
	long TurnAway = 0;//因队列已满被拒绝的出租车数量
	long Cars = 0;//加入队列的顾客数量
	long Served = 0;//在模拟时间段接到乘客地出租车数量
	long SumLine = 0;//累积的队列总长
	int WaiTime = 0;//当前到第一辆车载客出发的时间
	double MinPerCars;//出租车到来的平均时间
	long SumLineWait = 0;//队列累积的等待时间
	int t, tt;
	double Ave[1000];
	double SumAv[1000];


	puts("请输入模拟次数（不要超过1000次）：");
	scanf_s("%d", &t);
	tt = t;//tt为循环次数
	puts("请输入模拟时长：");
	scanf_s("%lf", &Hours);
	puts("请输入平均每小时到机场排队的出租车数量：");
	scanf_s("%d", &Perhour);
	srand((unsigned int)time(0));

	while (tt--)//模拟开始
	{
		Cars = 0; Served = 0; SumLine = 0;
		TurnAway = 0; WaiTime = 0; SumLineWait = 0;
		InitializeQueue(&Line);

		CycleLimit = MIN_PER_HR * Hours * 60;
		MinPerCars = (MIN_PER_HR * 60) / Perhour;

		for (Cycle = 0.0; Cycle < CycleLimit; Cycle++)
		{
			if (NewCar(MinPerCars))
			{
				if (QueueIsFull(&Line))
					TurnAway++;
				else
				{
					Cars++;
					Temp = Cartime(Cycle);
					EnQueue(Temp, &Line);
				}
			}
			if (WaiTime <= 0 && !QueueIsEmpty(&Line))
			{
				DeQueue(&Temp, &Line);
				WaiTime = Temp.BordingTime;
				SumLineWait += Cycle - Temp.Arrive;
				Served++;
			}
			if (WaiTime > 0)
				WaiTime--;
			SumLine += QueueItemCount(&Line);
		}
		if (Cars > 0)
		{
			printf("--------------------------------\n");
			printf("%-40s%-15ld\n", "进行排队的出租车总数（辆）：", Cars);
			printf("%-40s%-15ld\n", "接到乘客的出租车数量（辆）：", Served);
			printf("%-40s%-15ld\n", "由于场地限制拒绝的出租车数量（辆） ：", TurnAway);
			printf("%-40s%.2f\n", "出租车平均等待时间（秒）：", (double)SumLineWait / Served);
		}
		else
			printf("No Cars!");
		Ave[tt] = (double)SumLineWait / Served;
		SumAv[tt] = Cars;

		EmptyTheQueue(&Line);
		//printf("\n");
	}
	printf("--------------------------------\n");
	printf("%d 次模拟出租车等待时间平均值为 %.2f 分钟 ，进行排队出租车的"
		"（%.2f个小时）平均数为 %.2f 辆", t, Average(Ave, t) / 60, Hours, Average(SumAv, t));

	getchar();
	getchar();
	return 0;
};

int NewCar(double x)
{
	if (rand() * x / RAND_MAX < 1)
		return true;
	else
		return false;
}


Item Cartime(long when)
{
	Item cust;
	cust.BordingTime = 90;
	cust.Arrive = when;

	return cust;
}

void InitializeQueue(Queue* pq)
{
	pq->front = pq->rear = NULL;
	pq->items = 0;
}

int QueueIsFull(const Queue* pq)
{
	return pq->items == MAXCAR;
}

int QueueIsEmpty(const Queue* pq)
{
	return pq->items == 0;
}

int QueueItemCount(const Queue* pq)
{
	return pq->items;
}

int EnQueue(Item item, Queue* pq)
{
	Node* pnew;
	if (QueueIsFull(pq))
		return false;
	pnew = (Node*)malloc(sizeof(Node));
	if (pnew == NULL)
	{
		fprintf(stderr, "Unble to allocate memory!\n");
		exit(1);
	}
	CopyToNode(item, pnew);
	pnew->Next = NULL;
	if (QueueIsEmpty(pq))
		pq->front = pnew;
	else
		pq->rear->Next = pnew;
	pq->rear = pnew;
	pq->items++;

	return true;
}

int DeQueue(Item* pitem, Queue* pq)
{
	Node* pt;

	if (QueueIsEmpty(pq))
		return false;
	CopyToItem(pq->front, pitem);
	pt = pq->front;
	pq->front = pq->front->Next;
	free(pt);
	pq->items--;
	if (pq->items == 0)
		pq->rear = NULL;
	return true;
}

void EmptyTheQueue(Queue* pq)
{
	Item dummy;
	while (!QueueIsEmpty(pq))
		DeQueue(&dummy, pq);
}

static void CopyToNode(Item item, Node* pq)
{
	pq->item = item;
}

static void CopyToItem(Node* pq, Item* pi)
{
	*pi = pq->item;
}

double Average(double Ave[], int n)
{
	int i;
	double Sum = 0.0;
	for (i = 0; i <= n - 1; i++)
	{
		Sum += Ave[i];
	}
	return Sum / n;
}