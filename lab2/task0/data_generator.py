from random import randint

wNumbers = 3 # width of number in bytes
nNumbers = 3 # how many numbers in table

data = [wNumbers, nNumbers]

for i in range(wNumbers*nNumbers):
	data.append(randint(0,255))

file = open("data.bin", "wb")
file.write(bytearray(data))
file.close()
