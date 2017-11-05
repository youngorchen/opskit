#coding:utf-8

import codecs

import sys  

file_in_name = ''
file_out_name = ''
file_in_enc = ''
file_out_enc = ''
  
if __name__ == '__main__':  
    if len(sys.argv) > 4:  
        file_in_name = sys.argv[1]
        file_out_name = sys.argv[3]
        file_in_enc = sys.argv[2] 
        file_out_enc = sys.argv[4] 
    else:  
        print("Usage: %s file_in_name mode file_out_name mode  (mode: utf-8,gbk)",sys.argv[0])
        exit()

file_object = codecs.open(file_in_name,'r',file_in_enc)
out1 = codecs.open(file_out_name,'wb')

list_of_all_the_lines = file_object.readlines( )

for line in list_of_all_the_lines:
    #print(line)
    line1 = line.encode(file_out_enc,'ignore')
    #print(line1)
    print('.',end='')
    out1.write(line1)
    #break

file_object.close()
out1.close()
