while(True):
	#printf("Hello World!")
	user_input = input('Enter the required word!')
	if user_input == ' ':
		print("Hello World!")
	elif user_input == 'n':
		break
	else:
		print("Hello "+user_input)
