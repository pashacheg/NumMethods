#include <sys/socket.h>

#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define SZ 1024

int main()
{
	int listener = socket(AF_UNIX, SOCK_STREAM, 0);
	if (listener < 0)
	{
		printf("err 1\n");
		return -1;
	}
	
	char path[] = "chn";
	
	struct sockaddr_un addr;
	addr.sun_family = AF_UNIX;
	memcpy(addr.sun_path, path, sizeof(path));
	
	
	if (bind(listener, &addr, sizeof(addr)) < 0)
	{
		printf("err 2\n");
		return -1;
	}
	
	
	char buf[SZ];
	
	while(1)
	{
		listen(listener, 1);
		int sock = accept(listener, NULL, NULL);
		
		recv(sock, buf, SZ, 0);
		
		printf("%s", buf);
		
		close(sock);
	}
}
