/* CS 232 Homework 6 Explore concurrency and semaphores by writing a C console program 
 * 		that runs several different threads. Concurrent threads must use 
 *		semaphores to coordinate the resources in a simple bakery shop
 * 
 * Bug: final print statement doesn't print when baking is finished
 *
 * by Aaron Santucci
 * April 10, 2018
 */

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <semaphore.h>
#include <fcntl.h>

sem_t sem_baker;
sem_t sem_cashier;
sem_t sem_store;

int loaves = 0;
int customers = 0;

int loaves_max = 10;
int customer_max = 10;

pthread_t customer_threads[10];


void* bake_bread() {
	// baker "swaps" to cashier position when there is a customer waiting
	while (loaves <= loaves_max) {
		sem_wait(&sem_baker);
		loaves++;
		fprintf(stderr, "Baking a loaf of bread...\n");
		sem_post(&sem_baker);
		sleep(1);					// wait point
		fprintf(stderr, "Loaf of bread set up for sale.\n\n");
	}
}



void* customer_queue(void* id) 	{
	// let up to five customers in
	sem_wait(&sem_store);
	fprintf(stderr, "Customer %d entering the store...\n", id);
	// let one to the front of the line
	sem_wait(&sem_cashier);
	fprintf(stderr, "Customer %d is waiting for bread...\n", id);

	while(1) {		
		sem_wait(&sem_baker);
		sleep(1);					// wait point
		if (loaves > 0) {
			fprintf(stderr, "Customer %d has received their bread...\n", id);
			loaves--;
			sleep(1);				// wait point
			fprintf(stderr, "Customer %d has received their receipt...\n", id);
			sem_post(&sem_baker);
			break;
		}
		sem_post(&sem_baker);	
	}
	
	sleep(1);						// wait point
	customers--;
	fprintf(stderr, "Customer %d has left the store.\n\n", id);
	sem_post(&sem_cashier);
	sem_post(&sem_store);
}

int main (int argc, char * argv[]) {
	int id = 0;
	fprintf(stderr, "---Bake shop starting---\n\n");
	
	sem_init(&sem_baker, 0, 1);
	sem_init(&sem_cashier, 0, 1);
	sem_init(&sem_store, 0, 5);
	
	// baker thread
	pthread_t baker_thread;
    pthread_create(&baker_thread, NULL, bake_bread, NULL);
		
	// customer threads
	for (int id = 1; id <= customer_max; id++) {
		customers ++;
		pthread_create( &(customer_threads[id]), NULL, customer_queue, (void*) id);
  	}
	
	pthread_exit(NULL);
	fprintf(stderr, "---Baking is done---\n\n");
	exit(0);
}


