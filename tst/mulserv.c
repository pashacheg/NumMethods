#include <sys/socket.h>
#include <netinet/in.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <pthread.h>

#define SZ 1024


unsigned int mkip()
{
	unsigned int arr[] = {192, 168, 1, 64},
		ip = 0;
	
	for (int i = 0; i < 4; ++i)
	{
		arr[i] <<= 24 - 8 * i;
		ip += arr[i];
	}
	
	return ip;
}


typedef struct { char key[32]; int val; void* next; } List;
typedef struct { int lstn; List* list; } Exch;

void addList (List* ls, List* el)
{
	List* ptr = NULL;
	for (ptr = ls; ptr->next; ptr = ptr->next);
	
	ptr->next = el;
}

int getVal(const List* ls, const char* key)
{
	const List* ptr = NULL;
	for (ptr = ls; ptr && strcmp(ptr->key, key); ptr = ptr->next);
	
	return ptr ? ptr->val : -1;
}

void* getMessThr(void* data)
{
	List* user = (List*)data;
	int sock = user->val;
	
	while(1)
	{
		char bufi[SZ] = "";
		int br = recv(sock, bufi, SZ, 0);
		if (br <= 0)
		{
			close(sock);
			free(user);
			return NULL;
		}
		printf("%s: %s\n", user->key, bufi);			
	}
	
	close(sock);
	free(user);
	return NULL;
}

void* getConnThr(void* data)
{
	Exch* ptr = (Exch*)data;
	int listener = ptr->lstn;
	List* ls = ptr->list;

	
	while(1)
	{
		int sock = accept(listener, NULL, NULL);
		puts("socket accepted");
		
		if (sock < 0)
		{
			perror("accept");
			return NULL;
		}
		
		const char newus[] = "Hello! Enter your name:\n";
		send(sock, newus, sizeof(newus), 0);
		
		char bufi[SZ] = "";
		int br = recv(sock, bufi, SZ, 0);
		
		if (br <= 0) close(sock);
		else
		{
			printf("New User: %s\n", bufi);
			
			List* new_user = malloc(sizeof(List));
			memcpy(new_user->key, bufi, br);
			new_user->val = sock;
			new_user->next = NULL;
			
			addList(ls, new_user);
			
			pthread_t thr;
			pthread_create(&thr, NULL, getMessThr, new_user);
		}
	}
	
	return NULL;
}


int main()
{
	int listener = socket(AF_INET, SOCK_STREAM, 0);
	if (listener < 0)
	{
		printf("err 1\n");
		return -1;
	}
	
	
	struct sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_port = htons(3425);
	addr.sin_addr.s_addr = htonl(mkip()); // INADDR_ANY
	
	if (bind(listener, (struct sockaddr *)&addr, sizeof(addr)) < 0)
	{
		printf("err 2\n");
		perror("bind");
		return -1;
	}

	if (listen(listener, 5) < 0)
	{
		perror("listen");
		return -1;
	}
	
	List ls;
	ls.val = 0;
	ls.next = NULL;
	
	Exch data;
	data.lstn = listener;
	data.list = &ls;
	
	pthread_t thr;
	pthread_create(&thr, NULL, getConnThr, &data);
	
	int sock = -1;
	
	while(1)
	{
		char bufo[SZ] = "";
		scanf("%s", bufo);
		
		int cnt;
		for (cnt = 0; bufo[cnt]; ++cnt);
		
		char* cmnd = malloc(cnt);
		memcpy(cmnd, bufo, cnt);
		
		
		if (!strcmp(cmnd, "all") && sock == -1)
		{
			// code...
		}
		else if (!strcmp(cmnd, "!") && sock != -1)
		{
			sock = -1;
		}
		else
		{
			
			if (sock == -1) 
			{
				if ((sock = getVal(&ls, cmnd)) == -1) puts("user doesn't exist");
			}
			else
			{
				send(sock, cmnd, cnt, 0);
			}
			
		}
		
		free(cmnd);
	}
	
}
