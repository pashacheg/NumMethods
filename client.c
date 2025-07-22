#include <sys/socket.h>
#include <sys/un.h>

#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define SZ 1024

int main()
{
	int clnt = socket(AF_UNIX, SOCK_STREAM, 0);
	if (clnt < 0)
	{
		printf("err 1\n");
		return -1;
	}
	char path[] = "chn";
	
	struct sockaddr_un addr;
	addr.sun_family = AF_UNIX;
	memcpy(addr.sun_path, path, sizeof(path));
	
	if (connect(clnt, (struct sockaddr *)&addr, sizeof(addr)) < 0)
	{
		printf("err 2\n");
		return -1;
	}
	
	char msg[SZ];
	
	scanf("%s", msg);
	
	send(clnt, msg, SZ, 0);
	
	close(clnt);
}
