for server in rp01 rp02 rp03 rp04
	do 
		echo -------------
		echo ssh contx@$server $@
		ssh contx@$server $@
		echo -------------
	
done
