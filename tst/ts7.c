#include <unistd.h>
#include <fcntl.h>

#include <signal.h>
#include <stdio.h>
#define BUF_SIZE 256

volatile int flag = 0;

void handler(int sig)
{
	flag = 1;
}

int main(int argc, char** argv)
{
	if (!argc) { return -1; }

	int fd = open(argv[1], O_RDONLY);
	
	if (fd == -1) { return -1; }
	
	int new_fd;
	char buf[BUF_SIZE];
	
	pid_t pid = fork();
	
	if (pid == -1) { return -1;	}
	
	if (pid)
	{
		new_fd = open("parent_copy", O_RDWR | O_CREAT);
		if (new_fd == -1) { return -1; }
		puts("Parent:");
	}
	else
	{
		new_fd = open("child_copy", O_RDWR | O_CREAT);
		if (new_fd == -1) { return -1; }
		
		signal(SIGUSR1, handler);
		
		while(!flag) { pause(); } // waiting for signal from parent proccess
		
		lseek(fd, 0, SEEK_SET);
		
		puts("Child:");
	}
	
	
	/*  copying proccess... */
	
	int cnt = read(fd, buf, BUF_SIZE);
	while(cnt)
	{
		write(new_fd, buf, cnt);
		
		cnt = read(fd, buf, BUF_SIZE);
	}
	
	
	/*  printing proccess... */
	
	lseek(fd, 0, SEEK_SET);
	cnt = read(fd, buf, BUF_SIZE);
	while(cnt)
	{
		write(1, buf, cnt);
		
		cnt = read(fd, buf, BUF_SIZE);
	}
	
	
	
	if (pid)
	{
		kill(pid, SIGUSR1);
	}
	
}
