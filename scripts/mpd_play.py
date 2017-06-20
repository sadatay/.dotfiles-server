#!/usr/bin/env python2                                                       
import os                                                                                               
import sys                                                                                              
                                                                                                        
MPD_ROOT = '/home/rtor/music'                                                                        
TMP_DIR = 'external'                                                                                    
                                                                                                        
if not len(sys.argv) > 1:                                                                               
    print("Usage:\n{0} <files>".format(sys.argv[0]))                                                    
    sys.exit(1)                                                                                         
                                                                                                        
def still_updating():                                                                                   
    return 'Updating DB' in os.popen('mpc').read()                                                      
                                                                                                        
links = []                                                                                              
for file in sys.argv[1:]:                                                                               
    linkname = os.path.join(TMP_DIR, os.path.basename(file))                                            
    try:                                                                                                
        os.symlink(os.path.abspath(file), os.path.join(MPD_ROOT, os.path.basename(file)))                             
    except OSError:                                                                                     
        pass                                                                                            
    print("Adding " + linkname)                                                                         
    links.append(linkname)                                                                              
                                                                                                        
os.system('mpc update {0} >/dev/null'.format(TMP_DIR))                                                  
                                                                                                        
while still_updating():                                                                                 
    pass                                                                                                
                                                                                                        
for link in links:                                                                                      
    os.system('mpc add "{0}"'.format(link))