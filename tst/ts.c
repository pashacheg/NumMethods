#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define BUF_SIZE 1024

typedef struct
{
	void* left_node;
	void* right_node;
	char* str;
} list;

list* link_to_right(list* last_node, list* node) 
// links node to right pointer of the last_node. last_node must be the end of list
{
	if (!node) { return NULL; }
	
	if (!last_node) { return node; }
	
	for (; last_node->right_node; last_node = last_node->right_node);
	
	last_node->right_node = node;
	node->left_node = last_node;
	
	return node;
}

void rem_node(list* node) // removes node from list
{
	if (!node) { return; }

	if (node->left_node)
	{
		((list*)(node->left_node))->right_node = node->right_node;
	}
	
	if (node->right_node)
	{
		((list*)(node->right_node))->left_node = node->left_node;
	}
	
	free(node->str);
	free(node);
}


void travel_list(list* ls)
{
	if (ls->left_node) { travel_list(ls->left_node); }
	
	printf("%s", ls->str);
}

int main(int argc, char** argv)
{
	if (argc < 4) { return -1; }
	
	FILE *f1 = fopen(argv[1], "r"), // reading
		 *f2 = fopen(argv[2], "w"); // writing
	
	if (!f1 || !f2) { return -1; }
	
	list* l_ptr = NULL;
	int ch = 0; // checking for consistance of a visible symbols: 1- string consists visible symbol, 0- else
	int fl = 0;  // fl == 1 if string is more then BUF_SIZE
	
	unsigned int sz = 0;
	
	while (!feof(f1))
	{
		if (!fl)
		{
			list* new_nd = calloc(1, sizeof(list));
			if (!new_nd) { return -1; }
			
			l_ptr = link_to_right(l_ptr, new_nd);
		}
		
		l_ptr->str = realloc(l_ptr->str, (sz + 1) * BUF_SIZE);
		if (!l_ptr->str) { return -1; }
		
		fgets(l_ptr->str + sz * BUF_SIZE - sz, BUF_SIZE, f1);
		
		int i = 0;
		for (; l_ptr->str[i + sz * BUF_SIZE - sz]; ++i)
		{
			ch = ch || (l_ptr->str[i] > 31 && l_ptr->str[i] < 127);
		}
		
		if (i == (BUF_SIZE - 1) && l_ptr->str[i - 1 + sz * BUF_SIZE - sz] != '\n')
		{
			fl = 1;
			sz++;
			
			continue;
		}
		
		fl = 0;
		sz = 0;
		
		if (!ch)
		{
			list* node_to_rem = l_ptr;
			l_ptr = l_ptr->left_node;
			
			rem_node(node_to_rem);
		}
		
		ch = 0;
	}

	travel_list(l_ptr);
}
