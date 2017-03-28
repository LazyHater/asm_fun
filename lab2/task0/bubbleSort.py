from random import randint

def swap(tab, i, j):
	tab[i], tab[j] = tab[j], tab[i]
	
def sort(tab):
	n = len(tab)
	while(n>1):
		for i in range(0, n-1):
			print(i)
			if tab[i] < tab[i+1]:
				swap(tab, i, i+1)
		n = n - 1
		

tab = []
for i in range(0, 3):
	tab.append(randint(0,255))
print(tab)
sort(tab)
print(tab)
