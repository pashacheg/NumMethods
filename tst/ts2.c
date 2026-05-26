#include <fcntl.h>
#include <unistd.h>
#include <poll.h>

#define BUF_SIZE 128

struct pollfd pfds[3];
// pfds[0] - pfd for writing data into file
// pfds[1] - pfd for reading data from file
// pfds[2] - pfd for reading data from stdin

char buf_to_write[BUF_SIZE + 1]; // buf for writing data into file
size_t sz_buf_wr = 0;			 // size of a buf_to_write

char buf_to_read[BUF_SIZE + 1];  // for reading data from file


void proc_in(int fd) // try read from file
{	

	
	int cnt = read(fd, fd == 0 ? buf_to_write : buf_to_read, BUF_SIZE);
	if (cnt == -1) { return; }
	
	
	if (fd == 0)
	{
		buf_to_write[cnt] = '\0';
		sz_buf_wr = cnt + 1;
		pfds[0].events = POLLOUT;
		return;
	}
	
	buf_to_read[cnt] = '\0';
	
	write(1, buf_to_read, cnt + 1);
}

void proc_out(int fd) // try write into file
{			
	write(fd, buf_to_write, sz_buf_wr);
	
	pfds[0].events = 0;
}

int main(int argc, char** argv)
{
	if (argc < 3) { return -1; }
	
	int fd_out = open(argv[1], O_WRONLY);
	int fd_in  = open(argv[2], O_RDONLY);
	
	if (fd_out == -1 || fd_in == -1) { return -1; }
	
	pfds[0].fd = fd_out;
	pfds[0].events = 0;
	
	pfds[1].fd = fd_in;
	pfds[1].events = POLLIN;
	
	pfds[2].fd = 0;
	pfds[2].events = POLLIN;
	
	while (1)
	{
		int cnt = poll(pfds, 2, -1); // waiting for ready fd*
		if (cnt == -1) { return -1; }
		
		for (int i = 0; i < 3; ++i)
		{
			switch (pfds[i].revents)
			{
			case POLLIN:  proc_in(pfds[i].fd); break;
			case POLLOUT: proc_out(pfds[i].fd); break;
			}
		}
		
	}
}
