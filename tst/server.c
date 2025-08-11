#include <sys/socket.h>
#include <netinet/in.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


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

	if (listen(listener, 1) < 0)
	{
		perror("listen");
		return -1;
	}
	
	char buf[SZ];
	int br;

	while(1)
	{
		puts("waiting a socket");
		int sock = accept(listener, NULL, NULL);
		
		puts("socket accepted");
		
		if (sock < 0)
		{
			perror("accept");
			return -1;
		}
		
		while(1)
		{
			br = recv(sock, buf, SZ, 0);
			if (br <= 0) break;
			printf("client: %s\n", buf);
			
			printf("you: ");
			scanf("%s", buf);
			
			int cnt;
			for (cnt = 0; buf[cnt]; ++cnt);
			
			char* msg = malloc(cnt);
			memcpy(msg, buf, cnt);
			
			send(sock, msg, cnt, 0);
			
			free(msg);
		}
	
		close(sock);
	}
}
