#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <inttypes.h>
#include <math.h>

typedef enum {dm, fa} cache_map_t;
typedef enum {uc, sc} cache_org_t;
typedef enum {instruction, data} access_t;

typedef struct {
    uint32_t address;
    access_t accesstype;
} mem_access_t;

// DECLARE CACHES AND COUNTERS FOR THE STATS HERE
int blocknum;
int indexnum;
int tagvalue;
int indexvalue;
int i;
int cache1[64];//For both UC and Instruction Cache of SC
int cache2[32];//For Data Cache of SC
int cache1count = 0;
int cache2count = 0;
int accesscount = 0;
int hitcount = 0;
int accesscount2 = 0;
int hitcount2 = 0;

uint32_t cache_size; 
uint32_t block_size = 64;
cache_map_t cache_mapping;
cache_org_t cache_org;


/* Reads a memory access from the trace file and returns
 * 1) access type (instruction or data access
 * 2) memory address
 */
mem_access_t read_transaction(FILE *ptr_file) {
    char buf[1000];
    char* token;
    char* string = buf;
    mem_access_t access;

    if (fgets(buf,1000, ptr_file)!=NULL) {

        /* Get the access type */
        token = strsep(&string, " \n");        
       if (strcmp(token,"I") == 0) {
            access.accesstype = instruction;
        } else if (strcmp(token,"D") == 0) {
            access.accesstype = data;
        } else {
            printf("Unkown access type\n");
            exit(0);
        }
        
        /* Get the access type */        
        token = strsep(&string, " \n");
        access.address = (uint32_t)strtol(token, NULL, 16);

        return access;
    }

    /* If there are no more entries in the file,  
     * return an address 0 that will terminate the infinite loop in main
     */
    access.address = 0;
    return access;
}


void main(int argc, char** argv)
{

    /* Read command-line parameters and initialize:
     * cache_size, cache_mapping and cache_org variables
     */

    if ( argc != 4 ) { /* argc should be 2 for correct execution */
        printf("Usage: ./cache_sim [cache size: 128-4096] [cache mapping: dm|fa] [cache organization: uc|sc]\n");
        exit(0);
    } else  {
        /* argv[0] is program name, parameters start with argv[1] */

        /* Set cache size */
        cache_size = atoi(argv[1]);

        /* Set Cache Mapping */
        if (strcmp(argv[2], "dm") == 0) {
            cache_mapping = dm;
        } else if (strcmp(argv[2], "fa") == 0) {
            cache_mapping = fa;
        } else {
            printf("Unknown cache mapping\n");
            exit(0);
        }

        /* Set Cache Organization */
        if (strcmp(argv[3], "uc") == 0) {
            cache_org = uc;
        } else if (strcmp(argv[3], "sc") == 0) {
            cache_org = sc;
        } else {
            printf("Unknown cache organization\n");
            exit(0);
        }
    }


    /* Open the file mem_trace.txt to read memory accesses */
    FILE *ptr_file;
    ptr_file =fopen("mem_trace.txt","r");
    if (!ptr_file) {
        printf("Unable to open the trace file\n");
        exit(1);
    }

    //I initialize these two values outside the while loop.
    blocknum = cache_size/block_size;
    indexnum = log2(blocknum);

    /* Loop until whole trace file has been read */
    mem_access_t access;
    while(1) {
        access = read_transaction(ptr_file);
        //If no transactions left, break out of loop
        if (access.address == 0)
            break;

	/* Do a cache access */
        if (cache_mapping == dm) {
	  if (cache_org == uc) {
	    //Direct Mapped with Unified Cache part
	    accesscount++;
	    tagvalue = access.address / pow(2,6+indexnum);
	    indexvalue = (access.address / 64) - (tagvalue * pow(2,indexnum));
	    if (tagvalue == cache1[indexvalue]){
	      hitcount++;
	    }else{
	      cache1[indexvalue] = tagvalue;
	    }
	  }else{
	    //Direct Mapped with Split Cache part
	    tagvalue = access.address / pow(2,5+indexnum);//half the index when using split
	    indexvalue = (access.address / 64) - (tagvalue * pow(2,indexnum-1));
	    if (access.accesstype == data){
	      //data part
	      accesscount++;
	      if (tagvalue == cache1[indexvalue]){
	        hitcount++;
	      }else{
		cache1[indexvalue] = tagvalue;
	      }
	    }else{
	      //instruction part
	      accesscount2++;
	      if (tagvalue == cache2[indexvalue]){
	        hitcount2++;
	      }else{
		cache2[indexvalue] = tagvalue;
	      }
	    }
	  }
	}else{
	  if (cache_org == uc) {
	    //Fully Associative with Unified Cache part
	    accesscount++;
	    tagvalue = (access.address / 64);
	    indexvalue =0;//I use the indexvalue as a boolean to verify hit/miss.
	    for (i=0;i<64;i++){
	      if(tagvalue == cache1[i]){
		indexvalue++;
	      }
	    }
	    if(indexvalue){
	      hitcount++;
	    }else{
	      cache1[cache1count]=tagvalue;
	      cache1count++;
	      if(cache1count==blocknum){cache1count=0;}
	    }
	  }else{
	    //Fully Associative with Split Cache part
	    tagvalue = (access.address / 64);
	    indexvalue =0;
	    if(access.accesstype == data){
	      //data part
	      accesscount++;
	      for (i=0;i<32;i++){
		if(tagvalue==cache1[i]){
		  indexvalue++;
		}
	      }
	      if(indexvalue){
		hitcount++;
	      }else{
		cache1[cache1count]=tagvalue;
		cache1count++;
		if(cache1count==blocknum){cache1count=0;}
	      }
	    }else{
	      //instruction part
	      accesscount2++;
	      for (i=0;i<32;i++){
		if(tagvalue==cache2[i]){
		  indexvalue++;
		}
	      }
	      if(indexvalue){
		hitcount2++;
	      }else{
		cache2[cache2count]=tagvalue;
		cache2count++;
		if(cache2count==blocknum){cache2count=0;}
	      }
	    }
	  }
	}
    }

    /* Print the statistics */
    if(cache_org==uc){
      printf("U.accesses: %d\nU.hits: %d\nU.hit rate: %1.3f\n", 
	     accesscount,hitcount,(hitcount*1.0)/accesscount);
    }else{
      printf("I.accesses: %d\nI.hits: %d\nI.hit rate: %1.3f\n\nD.accesses: %d\nD.hits: %d\nD.hit rate: %1.3f\n",
	     accesscount2,hitcount2,((hitcount2*1.0)/accesscount2),
	     accesscount,hitcount,((hitcount*1.0)/accesscount));
    }

    /* Close the trace file */
    fclose(ptr_file);

}

