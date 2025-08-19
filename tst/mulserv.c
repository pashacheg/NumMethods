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


typedef struct { char key[32]; int val; void* next; void* prev; } List;
typedef struct { int lstn; List* list; } Exch;

void addList (List* ls, List* el)
{
	List* ptr = NULL;
	for (ptr = ls; ptr->next; ptr = ptr->next);
	
	ptr->next = el;
	el->prev = ptr;
}

void remNode(List* ls)
{
	if (!ls) return;
	else if (!ls->next && ls->prev)
	{
		List* ptr = (List*)ls->prev;
		ptr->next = NULL;
	}
	else if (ls->next && !ls->prev)
	{
		List* ptr = (List*)ls->next;
		ptr->prev = NULL;
		return;
	}
	else if (!ls->next && !ls->prev) return;
	else
	{
		List* ptr = (List*)ls->prev;
		ptr->next = ls->next;
		
		ptr = (List*)ls->next;
		ptr->prev = ls->prev;
	}
	
	free(ls);
}

int getVal(const List* ls, const char* key)
{
	const List* ptr = NULL;
	for (ptr = ls; ptr && strcmp(ptr->key, key); ptr = ptr->next);
	
	return ptr ? ptr->val : -1;
}

List* getList(List* ls, const char* str)
{
	for (ls; ls && strcmp(ls->key, str); ls = ls->next);
	
	return ls;
}

void printList(const List* ls)
{
	for (const List* ptr = ls; ptr; ptr = ptr->next)
	{
		if (!ptr->key[0]) continue;
		
		printf("%s\n", ptr->key);
	}
}

void discSock(List* ls)
{
	close(ls->val);
	remNode(ls);
}


void* getMessThr(void* data)
{
	List* user = (List*)data;
	int sock = user->val;
	char echo = 0;
	
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
		
		if (!strcmp(bufi, "!disconnect"))
		{
			char* name = malloc(32);
			memcpy(name, user->key, 32);
			
			discSock(user);
			
			printf("user <%s> has disconnected\n", name);
			free(name);
			
			return NULL;
		}
		
		if (echo)
		{
			char* msg = malloc(br);
			memcpy(msg, bufi, br);
			
			send(sock, msg, br, 0);
			
			free(msg);
		}
		
		if (!strcmp(bufi, "!echo"))
		{
			echo = !echo;
		}
		else printf("%s: %s\n", user->key, bufi);			
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
			new_user->prev = NULL;
			
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
	ls.prev = NULL;
	
	Exch data;
	data.lstn = listener;
	data.list = &ls;
	
	pthread_t thr;
	pthread_create(&thr, NULL, getConnThr, &data);
	
	int sock = -1;
	char tab[32] = "#";
	
	while(1)
	{
		printf("%s:\n", tab);
		char bufo[SZ] = "";
		scanf("%s", bufo);
		
		int cnt;
		for (cnt = 0; bufo[cnt]; ++cnt);
		cnt++;
		
		char* cmnd = malloc(cnt);
		memcpy(cmnd, bufo, cnt);
		
		
		if (!strcmp(cmnd, "!all"))
		{			
			sock = -2;
			
			memcpy(tab + 6, "to all", 6);
			for (int i = 6; i < 32; ++i) tab[i] = '\0';
		}
		else if (!strcmp(cmnd, "!exit"))
		{
			sock = -1;
			tab[0] = '#';
			for (int i = 1; i < 32; ++i) tab[i] = '\0';
		}
		else if (!strcmp(cmnd, "!get.users"))
		{
			puts("connected users:");
			printList(&ls);
		}
		else
		{
			if (cmnd[0] == '!')
			{
				char* name = malloc(cnt - 1);
				memcpy(name, cmnd + 1, cnt - 1);
				List* user = getList(&ls, name);
				
				if (!user)
				{
					printf("user <%s> doesn't exist to remove\n", name);
					continue;
				}
				
				if (user->val == sock)
				{
					sock = -1;
					tab[0] = '#';
					for (int i = 1; i < 32; ++i) tab[i] = '\0';
				}
				
				discSock(user);
			}
			
			else if (sock == -1) 
			{
				if ((sock = getVal(&ls, cmnd)) == -1) puts("user doesn't exist");
				else
				{
					memcpy(tab + 3, cmnd, cnt);
					tab[0] = 't';
					tab[1] = 'o';
					tab[2] = ' ';
				}
			}
			else if (sock == -2)
			{
				for (List* ptr = ls.next; ptr; ptr = ptr->next)
				{
					send(ptr->val, cmnd, cnt, 0);
				}
			}
			else
			{
				send(sock, cmnd, cnt, 0);
			}
			
		}
		
		free(cmnd);
	}
	
}
